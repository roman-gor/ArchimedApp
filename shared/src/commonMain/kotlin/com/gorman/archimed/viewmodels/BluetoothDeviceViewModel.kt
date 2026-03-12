package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDataState
import com.gorman.archimed.states.bluetooth.ExperimentOnlineDataState
import com.gorman.archimed.states.bluetooth.SingleExperimentDataState
import com.gorman.archimed.states.bluetooth.StatusDeviceDataState
import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
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
    private val statusDeviceDataState = MutableStateFlow(StatusDeviceDataState())
    private val experimentOnlineDataState = MutableStateFlow(ExperimentOnlineDataState())
    private val experimentsHistoryDataState = MutableStateFlow(emptyList<ExperimentsHistoryDataState>())
    private val singleExperimentDataState = MutableStateFlow(SingleExperimentDataState())

    private data class DeviceResponsesDataState(
        val statusDeviceDataState: StatusDeviceDataState,
        val experimentOnlineDataState: ExperimentOnlineDataState,
        val experimentsHistoryDataState: List<ExperimentsHistoryDataState>,
        val singleExperimentDataState: SingleExperimentDataState
    )

    private data class DeviceParametersState(
        val deviceId: String?,
        val connectionState: DeviceConnectionState,
        val deviceType: DeviceType?
    )

    private val deviceResponsesDataState = combine(
        statusDeviceDataState,
        experimentOnlineDataState,
        experimentsHistoryDataState,
        singleExperimentDataState
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
            statusDeviceData = responseData.statusDeviceDataState,
            experimentOnlineDataState = responseData.experimentOnlineDataState,
            experimentsHistoryDataState = responseData.experimentsHistoryDataState,
            singleExperimentDataState = responseData.singleExperimentDataState
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
            experimentsHistoryDataState.value = emptyList()
            statusDeviceDataState.value = StatusDeviceDataState()
            experimentOnlineDataState.value = ExperimentOnlineDataState()
            singleExperimentDataState.value = SingleExperimentDataState()

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
                        bluetoothRepository.setDeviceType(null)
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
            is DeviceResponse.StatusDeviceData -> {
                val detectedType = parsedResponse.archimedesVersion
                logger.d("ViewModel", "Detected Device Type: $detectedType")
                statusDeviceDataState.value = parsedResponse.toUiState()
                logger.d("STATUS_UI_STATE", "${statusDeviceDataState.value}")
                bluetoothRepository.setDeviceType(detectedType)
            }
            is DeviceResponse.GetExperimentData -> {
                logger.d("ViewModel", "Downloaded packet #${parsedResponse.packetNumber}")
                singleExperimentDataState.value = parsedResponse.toUiState(deviceType.value?.sensorType)
                sendCommand(BluetoothUiEvent.DeviceCommand.SendNextDataPackage)
            }
            is DeviceResponse.GetExperimentsList -> {
                logger.d("Device Type", "${deviceType.value?.sensorType?.sensors}")
                val newItem = parsedResponse.toUiState(deviceType.value?.sensorType)
                experimentsHistoryDataState.update { currentList ->
                    val isDuplicate = currentList.any { it.experimentNumber == newItem.experimentNumber }
                    if (isDuplicate) currentList else currentList + newItem
                }
                logger.d("DOWNLOAD_DATA_UI_STATE", "${experimentsHistoryDataState.value}")
            }
            is DeviceResponse.ExperimentOnlineData -> {
                experimentOnlineDataState.value = parsedResponse.toUiState()
                logger.d("ONLINE_DATA_UI_STATE", "${experimentOnlineDataState.value}")
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

            //TODO(Need to define sensors type by these ids. It's very important. After this I'll can
            // to refactor block with device type and sensors type. And refactor models of requests
            BluetoothUiEvent.DeviceCommand.GetAllSensorsId -> listOf(DeviceRequest.GetAllSensorsId)
            //

            BluetoothUiEvent.DeviceCommand.GetSensorsValues -> listOf(
                setDateTimes(),
                DeviceRequest.GetAllSensorsValues
            )
            BluetoothUiEvent.DeviceCommand.GetExperimentsList -> listOf(
                DeviceRequest.GetStatus,
                DeviceRequest.GetAllExperimentsList
            )
            is BluetoothUiEvent.DeviceCommand.GetExperimentData -> {
                listOf(
                    DeviceRequest.GetStatus,
                    DeviceRequest.GetExperimentData(command.experimentNumber.toByte()),
                    DeviceRequest.SendNextPacket
                )
            }
            BluetoothUiEvent.DeviceCommand.SendNextDataPackage -> listOf(DeviceRequest.SendNextPacket)
            BluetoothUiEvent.DeviceCommand.ResendPrevDataPackage -> listOf(DeviceRequest.ResendPrevPacket)
            BluetoothUiEvent.DeviceCommand.ClearDeviceMemory -> {
                experimentsHistoryDataState.value = emptyList()
                singleExperimentDataState.value = SingleExperimentDataState()
                listOf(DeviceRequest.ClearDeviceMemory)
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

        val shouldCalibrate = when(command.shouldCalibrate) {
            true -> 0x01
            false -> 0x00
        }.toByte()

        return listOf(
            DeviceRequest.StopLogging,
            setDateTimes(),
            DeviceRequest.SetupLoggingParameters(
                sensors = sensorsArray.copyOf(),
                /**
                 * 0x02 - 1 measure per second
                 * 0x03 - 10 measures per second
                 * 0x04 - 100 measures per second ? **/
                rate = Rates.valueOf(command.sampleRate.toString()).byte,
                /**
                 * 0x00 - 10 samples
                 * 0x01 - 100 samples
                 * 0x02 - 1000 samples
                 * 0x03 - 10000 samples ? **/
                samples = Samples.valueOf(command.sampleCount.toString()).byte,
                /**
                 * 0x00 - Should not calibrate
                 * 0x01 - Should calibrate**/
                sensorsCalibrate = shouldCalibrate
            ),
            DeviceRequest.StartLogging
        )
    }

    private fun startDefaultLogging(): List<DeviceRequest> {
        val sensorsList = deviceType.value?.sensorType?.sensors ?: emptyList()

        val sensorsArray = sensorsList.fold(ByteArray(2)) { acc, sensor ->
            when (sensor.position) {
                0 -> acc[0] = (acc[0].toInt() or sensor.byteCode.toInt()).toByte()
                1 -> acc[1] = (acc[1].toInt() or sensor.byteCode.toInt()).toByte()
            }
            acc
        }

        return listOf(
            setDateTimes(),
            DeviceRequest.SetupLoggingParameters(
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
