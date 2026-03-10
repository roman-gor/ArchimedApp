package com.gorman.bluetooth.repository

import com.gorman.bluetooth.constants.DeviceCommands
import com.gorman.bluetooth.constants.UartServiceFilters
import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.mappers.DeviceCommandBuilder
import com.gorman.bluetooth.mappers.DeviceProtocolParser
import com.gorman.bluetooth.mappers.toDomain
import com.gorman.bluetooth.models.DeviceEvent
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.states.ConnectionPeripheralState
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import kotlin.uuid.ExperimentalUuidApi

@Suppress("TooManyFunctions")
internal class BluetoothRepository(
    private val bluetoothManager: BluetoothManager,
    private val delegate: BleDelegate,
    private val logger: Logger
) : IBluetoothRepository {
    private val _peripherals = bluetoothManager.peripherals

    override val peripherals = _peripherals.map { peripheralsNative ->
        peripheralsNative.map { it.toDomain() }
    }

    override val delegates = bluetoothManager.delegates

    private val _incomingUartMessages = MutableSharedFlow<DeviceResponse?>()
    override val incomingUartMessages = _incomingUartMessages.asSharedFlow()

    private val initializedPeripherals = mutableSetOf<String>()

    init {
        delegateEventsObserver()
    }

    override fun scan(filters: List<ServiceFilter>) { bluetoothManager.scan(filters) }

    override suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean) {
        val peripheral = getPeripheral(peripheralState)
        peripheral?.let { bluetoothManager.connect(it, autoConnect) }
    }

    override suspend fun disconnect(peripheralState: PeripheralDeviceState) {
        val peripheral = getPeripheral(peripheralState)
        peripheral?.let { bluetoothManager.disconnect(it) }
    }

    override fun deviceEvents(): SharedFlow<DeviceEvent> = delegate.events

    override suspend fun connectionState(peripheralState: PeripheralDeviceState): ConnectionPeripheralState? {
        val peripheral = getPeripheral(peripheralState)
        return peripheral?.let { bluetoothManager.connectionState(it).toDomain() }
    }

    @OptIn(ExperimentalUuidApi::class)
    override fun sendCommand(command: DeviceCommands, peripheralUuid: String) {
        CoroutineScope(Dispatchers.IO).launch {
            val writeCharacteristic = delegate.writeChar
            val readCharacteristic = delegate.readChar
            val peripheral = getPeripheral(PeripheralDeviceState(uuid = peripheralUuid))

            if (peripheral != null && writeCharacteristic != null && readCharacteristic != null) {
                val packetToSend = getPacketToSend(command)
                logger.d("UART_TX", "Sending command Status...")
                bluetoothManager.writeCharacteristic(
                    bluetoothPeripheral = peripheral,
                    bluetoothCharacteristic = readCharacteristic,
                    value = packetToSend
                )
            } else {
                logger.d(
                    "UART_TX",
                    "Error sending! Peripheral founded: ${peripheral != null}," +
                        " writeChar founded: ${writeCharacteristic != null}"
                )
            }
        }
    }

    private fun getPacketToSend(command: DeviceCommands): ByteArray = when (command) {
        DeviceCommands.GET_STATUS -> DeviceCommandBuilder.buildGetStatusCmd()
    }

    private suspend fun getPeripheral(peripheralState: PeripheralDeviceState): BluetoothPeripheral? {
        val currentList = _peripherals.first()
        return currentList.find { it.uuid == peripheralState.uuid }
    }

    @OptIn(ExperimentalUuidApi::class)
    private fun delegateEventsObserver() {
        CoroutineScope(Dispatchers.IO).launch {
            delegate.events.collect { event ->
                logger.d("RAW_EVENT", "Received event: ${event::class.simpleName}")
                if (event is DeviceEvent.OnCharacteristicValueChanged) {
                    logger.d("RAW_DATA", "UUID: ${event.characteristicUuid}, Data: ${event.byteArray.joinToString()}")
                }
                when (event) {
                    is DeviceEvent.OnDeviceConnected -> {
                        val peripheral = getPeripheral(PeripheralDeviceState(uuid = event.uuid))
                        peripheral?.let {
                            bluetoothManager.discoverServices(peripheral)
                        }
                    }
                    is DeviceEvent.OnServicesDiscovered -> {
                        if (!initializedPeripherals.contains(event.peripheral.uuid)) {
                            onServiceDiscovered(event)
                        } else {
                            logger.d("BLE_REPO", "Skip: Services already discovered for ${event.peripheral.uuid}")
                        }
                    }
                    is DeviceEvent.OnCharacteristicsDiscovered -> {
                        onCharacteristicsDiscovered(event)
                    }
                    is DeviceEvent.OnCharacteristicValueChanged -> {
                        onCharacteristicValueChanged(event)
                    }
                    is DeviceEvent.OnWriteCharacteristicResult -> {
                        bluetoothManager.readCharacteristic(
                            bluetoothPeripheral = event.peripheral,
                            bluetoothCharacteristic = delegate.readChar!!
                        )
                        logger.d("VALUE", "${delegate.readChar!!.value}")
                    }
                    else -> {}
                }
            }
        }
    }

    private suspend fun onCharacteristicValueChanged(event: DeviceEvent.OnCharacteristicValueChanged) {
        val txUuid = delegate.readChar?.uuid.toString().lowercase()
        logger.d("UART_RX", "Received: $txUuid")
        if (event.characteristicUuid.lowercase() == txUuid) {
            val parsedResponse = DeviceProtocolParser.parse(event.byteArray)
            logger.d("UART_RX", "Received: $parsedResponse")
            _incomingUartMessages.emit(parsedResponse)
        }
    }

    @OptIn(ExperimentalUuidApi::class)
    private fun onServiceDiscovered(event: DeviceEvent.OnServicesDiscovered) {
        val targetServiceUuid =
            UartServiceFilters.UART_SERVICE_UUID.value.lowercase()
        val targetService = event.peripheral.services.entries.find { service ->
            service.key.toString().lowercase() == targetServiceUuid
        }
        logger.d("Service", targetService?.value.toString())
        targetService?.let { targetService ->
            bluetoothManager.discoverCharacteristics(
                bluetoothPeripheral = event.peripheral,
                bluetoothService = targetService.value
            )
        }
    }

    @OptIn(ExperimentalUuidApi::class)
    private fun onCharacteristicsDiscovered(event: DeviceEvent.OnCharacteristicsDiscovered) {
        logger.d(
            "Characteristics",
            "BLE: Characteristics discovered! Ready to Read/Write."
        )

        val rxUuid = UartServiceFilters.UART_CHARACTERISTIC_RX.value.lowercase()
        val txUuid = UartServiceFilters.UART_CHARACTERISTIC_TX.value.lowercase()

        delegate.readChar =
            event.peripheral.characteristics.entries.find { characteristic ->
                characteristic.key.toString().lowercase() == rxUuid
            }?.value?.firstOrNull()
        delegate.writeChar =
            event.peripheral.characteristics.entries.find { characteristic ->
                characteristic.key.toString().lowercase() == txUuid
            }?.value?.firstOrNull()

        logger.d(
            "Characteristics",
            "Discovered. RX: ${delegate.readChar != null}, " + "TX: ${delegate.writeChar != null}"
        )

        if (delegate.readChar != null && !delegate.readChar!!.isNotifying) {
            logger.d("Characteristics", "Subscribing to Notifications...")
            initializedPeripherals.add(event.peripheral.uuid)
            bluetoothManager.notifyCharacteristic(
                bluetoothPeripheral = event.peripheral,
                bluetoothCharacteristic = delegate.readChar!!,
                notify = true,
            )
        }
    }
}
