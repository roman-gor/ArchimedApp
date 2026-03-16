package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.states.bluetooth.ExperimentOnlineData
import com.gorman.archimed.states.bluetooth.ExperimentsData
import com.gorman.archimed.states.bluetooth.StatusDeviceData
import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.constants.toSensorsList
import com.gorman.bluetooth.mappers.DeviceCommandBuilder.setDateTimes
import com.gorman.bluetooth.mappers.DeviceCommandBuilder.startDefaultLogging
import com.gorman.bluetooth.mappers.DeviceCommandBuilder.startLogging
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
    private val statusDeviceData = MutableStateFlow(StatusDeviceData())
    private val experimentOnlineData = MutableStateFlow(ExperimentOnlineData())
    private val experimentsHistoryData = MutableStateFlow(emptyList<ExperimentsData>())
    private val experimentsData = MutableStateFlow(ExperimentsData())
    private val availableDeviceSensors = MutableStateFlow(emptyMap<SensorType, Byte>())
    private val availableSensorsList: List<Byte>
        get() = availableDeviceSensors.value.values.toList()
    private var rawStatusResponse: DeviceResponse.StatusDeviceData? = null

    private var downloadingExperimentHeader: DeviceResponse.GetExperimentsData? = null
    private val downloadingRawDataBuffer = mutableListOf<Short>()

    private data class DeviceResponsesDataState(
        val statusDeviceData: StatusDeviceData,
        val experimentOnlineData: ExperimentOnlineData,
        val experimentsHistoryData: List<ExperimentsData>,
        val experimentsData: ExperimentsData
    )

    private data class DeviceParametersState(
        val deviceId: String?,
        val connectionState: DeviceConnectionState,
        val deviceType: DeviceType = DeviceType.UNKNOWN
    )

    private val deviceResponsesDataState = combine(
        statusDeviceData,
        experimentOnlineData,
        experimentsHistoryData,
        experimentsData
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
            statusDeviceData = responseData.statusDeviceData,
            experimentOnlineData = responseData.experimentOnlineData,
            experimentsHistoryDataState = responseData.experimentsHistoryData,
            experimentsData = responseData.experimentsData
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
            experimentsHistoryData.value = emptyList()
            statusDeviceData.value = StatusDeviceData()
            experimentOnlineData.value = ExperimentOnlineData()
            experimentsData.value = ExperimentsData()

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
                        sendCommand(BluetoothUiEvent.DeviceCommand.GetAllSensorsId)
                    }
                    is DeviceConnectionState.Disconnected -> {
                        observationJob?.cancel()
                        bluetoothRepository.setDeviceType(DeviceType.UNKNOWN)
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
                statusDeviceData.value = parsedResponse
                    .toUiState(availableSensorsList)
                rawStatusResponse = parsedResponse
                bluetoothRepository.setDeviceType(detectedType)
            }
            is DeviceResponse.GetSensorIdParams -> {
                availableDeviceSensors.value = parsedResponse.sensorsIdsMap
                rawStatusResponse?.let { rawStatus ->
                    statusDeviceData.value = rawStatus
                        .toUiState(availableSensorsList)
                }
                logger.d("Sensors Ids", availableSensorsList.toString())
            }
            is DeviceResponse.GetExperimentsData -> getExperimentData(parsedResponse)
            is DeviceResponse.ExperimentOnlineData -> {
                experimentOnlineData.value = parsedResponse.toUiState(availableSensorsList)
            }
            is DeviceResponse.Unknown -> logger.e("ViewModel", "Response is in unknown type")
            else -> logger.d("ViewModel", "Handled other response type")
        }
    }

    private fun getExperimentData(parsedResponse: DeviceResponse.GetExperimentsData) {
        if (parsedResponse.isFullHistory) {
            val newItem = parsedResponse.toUiState(availableSensorsList)
            experimentsHistoryData.update { currentList ->
                val isDuplicate = currentList.any { it.experimentNumber == newItem.experimentNumber }
                if (isDuplicate) currentList else currentList + newItem
            }
            logger.d("History", "$parsedResponse")
            return
        }

        if (parsedResponse.packetNumber == 0.toShort()) {
            logger.d("Data", "Started downloading experiment. Saving header...")
            downloadingExperimentHeader = parsedResponse
            downloadingRawDataBuffer.clear()
            downloadingRawDataBuffer.addAll(parsedResponse.sensorsValues)
        } else {
            downloadingRawDataBuffer.addAll(parsedResponse.sensorsValues)
            logger.d(
                "Data",
                "Glued packet ${parsedResponse.packetNumber}. Buffer size: ${downloadingRawDataBuffer.size}"
            )
        }

        if (isEndOfDownload()) {
            logger.d("Data", "Download complete! Total raw values: ${downloadingRawDataBuffer.size}")

            val header = downloadingExperimentHeader ?: return

            val completeResponse = header.copy(
                sensorsValues = downloadingRawDataBuffer.toList()
            )

            val finalExperimentData = completeResponse.toUiState(
                availableSensors = availableSensorsList
            )

            experimentsData.value = finalExperimentData
            logger.d("Data", "$finalExperimentData")

            downloadingExperimentHeader = null
            downloadingRawDataBuffer.clear()
        } else {
            sendCommand(BluetoothUiEvent.DeviceCommand.SendNextDataPackage)
        }
    }

    private fun isEndOfDownload(): Boolean {
        val header = downloadingExperimentHeader ?: return false

        val activeSensors = header.sensors.toSensorsList(availableSensorsList)
        val frameSize = activeSensors.sumOf { it.valuesCount }

        val expectedTotalValues = header.samplesCount * frameSize

        return downloadingRawDataBuffer.size >= expectedTotalValues
    }

    private fun getRequestByCommand(command: BluetoothUiEvent.DeviceCommand): List<DeviceRequest> =
        when (command) {
            BluetoothUiEvent.DeviceCommand.GetStatus -> listOf(DeviceRequest.GetStatus)
            BluetoothUiEvent.DeviceCommand.StartDefaultLogging -> startDefaultLogging(availableSensorsList)
            is BluetoothUiEvent.DeviceCommand.StartLogging -> startLogging(command, availableSensorsList)
            BluetoothUiEvent.DeviceCommand.StopLogging -> listOf(DeviceRequest.StopLogging)
            BluetoothUiEvent.DeviceCommand.GetAllSensorsId -> listOf(DeviceRequest.GetAllSensorsId)
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
                experimentsHistoryData.value = emptyList()
                experimentsData.value = ExperimentsData()
                experimentOnlineData.value = ExperimentOnlineData()
                listOf(DeviceRequest.ClearDeviceMemory)
            }
            BluetoothUiEvent.DeviceCommand.TerminateDownloading -> listOf(DeviceRequest.TerminateDownloading)
            BluetoothUiEvent.DeviceCommand.DeleteLastRecording -> listOf(DeviceRequest.DeleteLastRecording)
            BluetoothUiEvent.DeviceCommand.SetCurrentDateTime -> listOf(setDateTimes())
            BluetoothUiEvent.DeviceCommand.GetExternalSensorsData -> listOf(DeviceRequest.GetAllSensorsId)
        }
}
