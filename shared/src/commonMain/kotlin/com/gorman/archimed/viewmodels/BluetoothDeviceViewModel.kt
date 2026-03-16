package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDeviceState
import com.gorman.archimed.states.bluetooth.OnlineDataDeviceState
import com.gorman.archimed.states.bluetooth.SingleExperimentDeviceState
import com.gorman.archimed.states.bluetooth.StatusDeviceState
import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.mappers.toUiState
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

@Suppress("TooManyFunctions")
class BluetoothDeviceViewModel(
    private val bluetoothRepository: IBluetoothRepository,
    private val deviceResponseHandlerUseCase: DeviceResponseHandlerUseCase,
    private val logger: Logger
) : ViewModel() {

    private val selectedDeviceId = MutableStateFlow<String?>(null)
    private val scannedDevices = MutableStateFlow<Map<String, PeripheralDeviceState>>(emptyMap())
    private val connectionState = MutableStateFlow<DeviceConnectionState>(DeviceConnectionState.Disconnected())
    private val deviceType = bluetoothRepository.deviceType
    private var connectionJob: Job? = null
    private var observationJob: Job? = null
    private val statusDeviceState = MutableStateFlow(StatusDeviceState())
    private val onlineDataDeviceState = MutableStateFlow(OnlineDataDeviceState())
    private val experimentsHistoryDeviceState = MutableStateFlow(emptyList<ExperimentsHistoryDeviceState>())
    private val singleExperimentDeviceState = MutableStateFlow(SingleExperimentDeviceState())

    private data class DeviceResponsesDataState(
        val statusDeviceState: StatusDeviceState,
        val onlineDataDeviceState: OnlineDataDeviceState,
        val experimentsHistoryDeviceState: List<ExperimentsHistoryDeviceState>,
        val singleExperimentDeviceState: SingleExperimentDeviceState
    )

    private data class DeviceParametersState(
        val deviceId: String?,
        val connectionState: DeviceConnectionState,
        val deviceType: DeviceType
    )

    private val deviceResponsesDataState = combine(
        statusDeviceState,
        onlineDataDeviceState,
        experimentsHistoryDeviceState,
        singleExperimentDeviceState
    ) { status, onlineData, fullExperiments, singleExpData ->
        DeviceResponsesDataState(status, onlineData, fullExperiments, singleExpData)
    }

    private val deviceParametersState = combine(
        selectedDeviceId,
        connectionState,
        deviceType
    ) { id, connection, type ->
        DeviceParametersState(id, connection, type)
    }

    val deviceState: StateFlow<BluetoothDeviceState> = combine(
        scannedDevices,
        deviceParametersState,
        deviceResponsesDataState
    ) { devices, deviceParams, responseData ->

        val deviceFlows = devices.values.associate { peripheral ->
            val isTargetDevice = peripheral.uuid == deviceParams.deviceId

            peripheral.uuid to EnhancedBluetoothPeripheral(
                connected = isTargetDevice && deviceParams.connectionState
                    is DeviceConnectionState.Connected,
                connectedState = if (isTargetDevice) {
                    deviceParams.connectionState
                } else {
                    DeviceConnectionState.Disconnected()
                },
                peripheral = peripheral,
            )
        }

        BluetoothDeviceState(
            devices = deviceFlows,
            isScanning = true,
            selectedDeviceId = deviceParams.deviceId,
            selectedDeviceType = deviceParams.deviceType,
            statusDeviceData = responseData.statusDeviceState,
            onlineDataDeviceState = responseData.onlineDataDeviceState,
            experimentsHistoryDeviceState = responseData.experimentsHistoryDeviceState,
            singleExperimentDeviceState = responseData.singleExperimentDeviceState
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
                scannedDevices.update { currentDevices ->
                    currentDevices + (peripheralDeviceState.uuid to peripheralDeviceState)
                }
            }
        }
    }

    private fun connect(uuid: String?) {
        if (uuid == null) return

        viewModelScope.launch {
            experimentsHistoryDeviceState.value = emptyList()
            statusDeviceState.value = StatusDeviceState()
            onlineDataDeviceState.value = OnlineDataDeviceState()
            singleExperimentDeviceState.value = SingleExperimentDeviceState()

            val currentSelected = selectedDeviceId.value

            if (currentSelected != null && currentSelected != uuid) {
                logger.d("DISCONNECTING OLD", "Disconnecting $currentSelected before connecting to new")
                bluetoothRepository.disconnect(currentSelected)
            }

            selectedDeviceId.value = uuid
            observeConnectionState(uuid)
            logger.d("CONNECTING", "METHOD CONNECT WAS CALLED")
            runCatching {
                bluetoothRepository.connect(uuid)
            }.onFailure { e ->
                logger.d("CONNECTING", "Connection failed: ${e.message}")
                connectionState.value = DeviceConnectionState.Disconnected()
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
            val currentDeviceId = selectedDeviceId.value

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

    private fun observeConnectionState(uuid: String) {
        connectionJob?.cancel()
        connectionJob = viewModelScope.launch {
            bluetoothRepository.connectionState(uuid).collect { state ->
                logger.d("ConnectionState", state.toString())
                connectionState.value = state

                when (state) {
                    is DeviceConnectionState.Connected -> {
                        startUartObservation(uuid)
                        delay(300)
                        sendCommand(BluetoothUiEvent.DeviceCommand.GetStatus)
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
                        observeDeviceResponses(parsedResponse)
                    }
                }
        }
    }

    private fun observeDeviceResponses(parsedResponse: DeviceResponse) {
        when (parsedResponse) {
            is DeviceResponse.Status -> {
                val detectedType = parsedResponse.deviceType
                logger.d("ViewModel", "Detected Device Type: $detectedType")
                statusDeviceState.value = parsedResponse.toUiState()
                logger.d("STATUS_UI_STATE", "${statusDeviceState.value}")
                bluetoothRepository.setDeviceType(detectedType)
            }
            is DeviceResponse.DownloadData -> {
                logger.d("ViewModel", "Downloaded packet #${parsedResponse.packetNumber}")
                singleExperimentDeviceState.value = parsedResponse.toUiState(deviceType.value.sensorType)
                sendCommand(BluetoothUiEvent.DeviceCommand.SendNextDownload)
            }
            is DeviceResponse.DownloadInformation -> {
                logger.d("Device Type", "${deviceType.value.sensorType?.sensors}")
                val newItem = parsedResponse.toUiState(deviceType.value.sensorType)
                experimentsHistoryDeviceState.update { currentList ->
                    val isDuplicate = currentList.any { it.experimentNumber == newItem.experimentNumber }
                    if (isDuplicate) currentList else currentList + newItem
                }
                logger.d("DOWNLOAD_DATA_UI_STATE", "${experimentsHistoryDeviceState.value}")
            }
            is DeviceResponse.OnlineData -> {
                onlineDataDeviceState.value = parsedResponse.toUiState()
                logger.d("ONLINE_DATA_UI_STATE", "${onlineDataDeviceState.value}")
            }
            is DeviceResponse.Unknown -> logger.e("ViewModel", "Response is in unknown type")
            else -> logger.d("ViewModel", "Handled other response type")
        }
    }

    private fun getRequestByCommand(command: BluetoothUiEvent.DeviceCommand): List<DeviceRequest> =
        when (command) {
            BluetoothUiEvent.DeviceCommand.GetStatus -> listOf(DeviceRequest.GetStatus)
            BluetoothUiEvent.DeviceCommand.StartDefaultLogging -> startDefaultLogging()
            is BluetoothUiEvent.DeviceCommand.StartLogging -> startLogging(command)
            BluetoothUiEvent.DeviceCommand.StopLogging -> listOf(DeviceRequest.StopLogging)
            BluetoothUiEvent.DeviceCommand.GetAllSensorsId -> listOf(DeviceRequest.GetAllSensorsId)
            BluetoothUiEvent.DeviceCommand.GetSensorsValues -> listOf(
                setDateTimes(),
                DeviceRequest.StartLogging,
                DeviceRequest.GetAllSensorsValues
            )
            BluetoothUiEvent.DeviceCommand.GetDownloadedInfo -> listOf(
                DeviceRequest.GetStatus,
                DeviceRequest.DownloadAllRecordingInfo
            )
            is BluetoothUiEvent.DeviceCommand.GetDownloadedStoreData -> {
                listOf(
                    DeviceRequest.GetStatus,
                    DeviceRequest.DownloadStoreData(command.experimentNumber.toByte()),
                    DeviceRequest.SendNextDownloadingPacket
                )
            }
            BluetoothUiEvent.DeviceCommand.SendNextDownload -> listOf(DeviceRequest.SendNextDownloadingPacket)
            BluetoothUiEvent.DeviceCommand.ResendPrevDownload -> listOf(DeviceRequest.ResendPrevDownloadingPacket)
            BluetoothUiEvent.DeviceCommand.ClearAllSamplesMemory -> {
                experimentsHistoryDeviceState.value = emptyList()
                singleExperimentDeviceState.value = SingleExperimentDeviceState()
                listOf(DeviceRequest.ClearAllSamplesMemory)
            }
            BluetoothUiEvent.DeviceCommand.TerminateDownloading -> listOf(DeviceRequest.TerminateDownloading)
            BluetoothUiEvent.DeviceCommand.DeleteLastRecording -> listOf(DeviceRequest.DeleteLastRecording)
            BluetoothUiEvent.DeviceCommand.SetCurrentDateTime -> listOf(setDateTimes())
        }

    private fun startLogging(command: BluetoothUiEvent.DeviceCommand.StartLogging): List<DeviceRequest> {
        val sensorsArray = command.sensors.fold(ByteArray(2)) { acc, sensor ->
            when (sensor.position) {
                0 -> acc[0] = (acc[0].toInt() or sensor.byteCode.toInt()).toByte()
                1 -> acc[1] = (acc[1].toInt() or sensor.byteCode.toInt()).toByte()
            }
            acc
        }
        logger.d("SensorsArray", "${sensorsArray.toList()}")
        val rate = when(command.rate) {
            1 -> 0x02
            10 -> 0x03
            100 -> 0x04
            else -> 0x03
        }
        val samples = when(command.samples) {
            10 -> 0x00
            100 -> 0x01
            1000 -> 0x02
            else -> 0x01
        }
        val shouldCalibrate = when(command.shouldCalibrate) {
            true -> 1
            false -> 0
        }

        return listOf(
            DeviceRequest.StopLogging,
            setDateTimes(),
            DeviceRequest.ArchLoggingSetup(
                sensors = sensorsArray.copyOf(),
                /**
                 * 0x02 - 1 measure per second
                 * 0x03 - 10 measures per second
                 * 0x04 - 100 measures per second ? **/
                rate = rate.toByte(),
                /**
                 * 0x00 - 10 samples
                 * 0x01 - 100 samples
                 * 0x02 - 1000 samples
                 * 0x03 - 10000 samples ? **/
                samples = samples.toByte(),
                /**
                 * 0x00 - Should not calibrate
                 * 0x01 - Should calibrate**/
                sensorsCalibrate = shouldCalibrate.toByte()
            ),
            DeviceRequest.StartLogging
        )
    }

    private fun startDefaultLogging(): List<DeviceRequest> {
        val sensorsList = deviceType.value.sensorType?.sensors ?: emptyList()

        val sensorsArray = sensorsList.fold(ByteArray(2)) { acc, sensor ->
            when (sensor.position) {
                0 -> acc[0] = (acc[0].toInt() or sensor.byteCode.toInt()).toByte()
                1 -> acc[1] = (acc[1].toInt() or sensor.byteCode.toInt()).toByte()
            }
            acc
        }

        return listOf(
            setDateTimes(),
            DeviceRequest.ArchLoggingSetup(
                sensors = sensorsArray,
                rate = 0x03.toByte(),
                samples = 0x01.toByte(),
                sensorsCalibrate = 0x00.toByte()
            ),
            DeviceRequest.StartLogging
        )
    }

    private fun setDateTimes(): DeviceRequest.SetDateTime {
        val now: Instant = Clock.System.now()
        val localDateTime = now.toLocalDateTime(TimeZone.currentSystemDefault())
        return DeviceRequest.SetDateTime(
            day = localDateTime.day.toByte(),
            month = localDateTime.month.number.toByte(),
            year = (localDateTime.year % 100).toByte(),
            hour = localDateTime.hour.toByte(),
            min = localDateTime.minute.toByte(),
            sec = localDateTime.second.toByte()
        )
    }
}
