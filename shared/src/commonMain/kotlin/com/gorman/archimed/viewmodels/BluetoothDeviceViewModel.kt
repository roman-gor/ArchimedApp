package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.BluetoothUiEvent
import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.models.DeviceRequest
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseHandlerUseCase
import com.gorman.bluetooth.repository.IBluetoothRepository
import com.gorman.bluetooth.states.BluetoothDeviceState
import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import kotlinx.datetime.TimeZone
import kotlinx.datetime.number
import kotlinx.datetime.toLocalDateTime
import kotlin.time.Clock
import kotlin.time.Instant

class BluetoothDeviceViewModel(
    private val bluetoothRepository: IBluetoothRepository,
    private val deviceResponseHandlerUseCase: DeviceResponseHandlerUseCase,
    private val logger: Logger
) : ViewModel() {

    private val _selectedDeviceId = MutableStateFlow<String?>(null)
    val selectedDeviceId: StateFlow<String?> = _selectedDeviceId.asStateFlow()

    private val _scannedDevices = MutableStateFlow<Map<String, PeripheralDeviceState>>(emptyMap())

    private val _connectionState = MutableStateFlow<DeviceConnectionState>(DeviceConnectionState.Disconnected())

    private var connectionJob: Job? = null
    private var observationJob: Job? = null

    val deviceState: StateFlow<BluetoothDeviceState> = combine(
        _scannedDevices,
        selectedDeviceId,
        _connectionState,
        bluetoothRepository.deviceType
    ) { devicesMap, selectedId, connState, deviceType ->

        val deviceFlows = devicesMap.values.associate { peripheral ->
            val isTargetDevice = peripheral.uuid == selectedId

            peripheral.uuid to EnhancedBluetoothPeripheral(
                connected = isTargetDevice && connState is DeviceConnectionState.Connected,
                connectedState = if (isTargetDevice) connState else DeviceConnectionState.Disconnected(),
                peripheral = peripheral,
            )
        }

        BluetoothDeviceState(
            devices = deviceFlows,
            isScanning = true,
            selectedDeviceId = selectedId,
            selectedDeviceType = deviceType
        )
    }.onStart {
        scan()
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000L),
        initialValue = BluetoothDeviceState()
    )

    fun onUiEvent(uiEvent: BluetoothUiEvent) {
        when (uiEvent) {
            is BluetoothUiEvent.OnConnect -> connect(uiEvent.uuid)
            is BluetoothUiEvent.OnDisconnect -> disconnect(uiEvent.uuid)
            BluetoothUiEvent.OnScan -> scan()
            is BluetoothUiEvent.OnSendCommand -> sendCommand(uiEvent.command)
        }
    }

    private fun scan() {
        logger.d("SCAN STARTED", "Started")
        viewModelScope.launch {
            bluetoothRepository.scan().collect { peripheralDeviceState ->
                _scannedDevices.update { currentDevices ->
                    currentDevices + (peripheralDeviceState.uuid to peripheralDeviceState)
                }
            }
        }
    }

    private fun connect(uuid: String?) {
        if (uuid == null) return

        viewModelScope.launch {
            val currentSelected = _selectedDeviceId.value

            if (currentSelected != null && currentSelected != uuid) {
                logger.d("DISCONNECTING OLD", "Disconnecting $currentSelected before connecting to new")
                bluetoothRepository.disconnect(currentSelected)
            }

            _selectedDeviceId.value = uuid
            observeConnectionState(uuid)
            logger.d("CONNECTING", "METHOD CONNECT WAS CALLED")
            runCatching {
                bluetoothRepository.connect(uuid)
            }.onFailure { e ->
                logger.d("CONNECTING", "Connection failed: ${e.message}")
                _connectionState.value = DeviceConnectionState.Disconnected()
            }
        }
    }

    private fun observeConnectionState(uuid: String) {
        connectionJob?.cancel()
        connectionJob = viewModelScope.launch {
            bluetoothRepository.connectionState(uuid).collect { state ->
                logger.d("ConnectionState", state.toString())
                _connectionState.value = state

                when (state) {
                    is DeviceConnectionState.Connected -> {
                        startUartObservation(uuid)
                        delay(300)
                        sendCommand(BluetoothUiEvent.DeviceCommand.GET_STATUS)
                    }
                    is DeviceConnectionState.Disconnected -> {
                        observationJob?.cancel()
                        bluetoothRepository.setDeviceType(DeviceType.IDLE)
                    }
                    else -> Unit
                }
            }
        }
    }

    private fun startUartObservation(uuid: String) {
        observationJob?.cancel()
        observationJob = viewModelScope.launch(Dispatchers.IO) {
            bluetoothRepository.observePeripherals(uuid)
                .catch { e -> logger.d("UART_RX", "Observation error: ${e.message}") }
                .collect { bytes ->
                    val parsedResponses = deviceResponseHandlerUseCase(bytes)
                    logger.d("UART_RX", "Received: $parsedResponses")
                    parsedResponses.forEach { parsedResponse ->
                        logger.d("UART_RX", "Parsed: $parsedResponse")

                        when (parsedResponse) {
                            is DeviceResponse.Status -> {
                                val detectedType = parsedResponse.deviceType
                                logger.d("ViewModel", "Detected Device Type: $detectedType")
                                bluetoothRepository.setDeviceType(detectedType)
                            }
                            is DeviceResponse.DownloadData -> {
                                logger.d("ViewModel", "Downloaded packet #${parsedResponse.packetNumber}")
                                sendCommand(BluetoothUiEvent.DeviceCommand.SEND_NEXT_DOWNLOAD)
                            }
                            is DeviceResponse.Unknown -> logger.e("ViewModel", "Response is in unknown type")
                            else -> logger.d("ViewModel", "Handled other response type")
                        }
                    }
                }
        }
    }

    private fun disconnect(uuid: String?) {
        viewModelScope.launch {
            uuid?.let { bluetoothRepository.disconnect(uuid) }
            logger.d("DISCONNECTING", "METHOD CONNECT WAS CALLED")
        }
    }

    private fun sendCommand(command: BluetoothUiEvent.DeviceCommand) {
        viewModelScope.launch(Dispatchers.IO) {
            val requestCommands: List<DeviceRequest> = getRequestByCommand(command)
            val currentDeviceId = _selectedDeviceId.value

            if (currentDeviceId != null) {
                logger.d("ViewModel", "Start sending command: $command to $currentDeviceId")
                for (request in requestCommands) {
                    logger.d("ViewModel", "Sending specific request: ${request::class.simpleName}")

                    bluetoothRepository.sendCommand(request, currentDeviceId)

                    if (requestCommands.size > 1) delay(150)
                }
            } else {
                logger.d("ViewModel", "Cannot send command: No device selected!")
            }
        }
    }

    private fun getRequestByCommand(command: BluetoothUiEvent.DeviceCommand): List<DeviceRequest> =
        when (command) {
            BluetoothUiEvent.DeviceCommand.GET_STATUS -> listOf(DeviceRequest.GetStatus)
            BluetoothUiEvent.DeviceCommand.START_LOGGING -> {
                listOf(
                    DeviceRequest.ArchLoggingSetup(
                        sensors = byteArrayOf(0x00.toByte(), 0x02.toByte()),
                        rate = 0x03.toByte(),
                        samples = 0x00.toByte(),
                        sensorsCalibrate = 0x00.toByte()
                    ),
                    DeviceRequest.StartLogging
                )
            }
            BluetoothUiEvent.DeviceCommand.STOP_LOGGING -> listOf(DeviceRequest.StopLogging)
            BluetoothUiEvent.DeviceCommand.GET_ALL_SENSORS_ID -> listOf(DeviceRequest.GetAllSensorsId)
            BluetoothUiEvent.DeviceCommand.GET_SENSORS_VALUES -> listOf(
                DeviceRequest.StartLogging,
                DeviceRequest.GetAllSensorsValues
            )
            BluetoothUiEvent.DeviceCommand.GET_DOWNLOADED_INFO -> listOf(DeviceRequest.DownloadAllRecordingInfo)
            BluetoothUiEvent.DeviceCommand.GET_DOWNLOADED_STORE_DATA -> {
                listOf(
                    DeviceRequest.DownloadStoreData(2.toByte()),
                    DeviceRequest.SendNextDownloadingPacket
                )
            }
            BluetoothUiEvent.DeviceCommand.SEND_NEXT_DOWNLOAD -> listOf(DeviceRequest.SendNextDownloadingPacket)
            BluetoothUiEvent.DeviceCommand.RESEND_PREV_DOWNLOAD -> listOf(DeviceRequest.ResendPrevDownloadingPacket)
            BluetoothUiEvent.DeviceCommand.CLEAR_ALL_SAMPLES_MEMORY -> listOf(DeviceRequest.ClearAllSamplesMemory)
            BluetoothUiEvent.DeviceCommand.TERMINATE_DOWNLOADING -> listOf(DeviceRequest.TerminateDownloading)
            BluetoothUiEvent.DeviceCommand.DELETE_LAST_RECORDING -> listOf(DeviceRequest.DeleteLastRecording)
            BluetoothUiEvent.DeviceCommand.SET_DATE_TIME -> {
                val now: Instant = Clock.System.now()
                val localDateTime = now.toLocalDateTime(TimeZone.currentSystemDefault())
                listOf(
                    DeviceRequest.SetDateTime(
                        day = localDateTime.day.toByte(),
                        month = localDateTime.month.number.toByte(),
                        year = localDateTime.year.toByte(),
                        hour = localDateTime.hour.toByte(),
                        min = localDateTime.minute.toByte(),
                        sec = localDateTime.second.toByte()
                    )
                )
            }
        }
}
