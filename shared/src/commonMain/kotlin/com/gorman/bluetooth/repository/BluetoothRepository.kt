package com.gorman.bluetooth.repository

import com.gorman.bluetooth.constants.DeviceCommands
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.mappers.DeviceCommandBuilder
import com.gorman.bluetooth.mappers.toDomain
import com.gorman.bluetooth.states.CharacteristicState
import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import com.juul.kable.Peripheral
import com.juul.kable.characteristicOf
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.flow.update
import kotlin.uuid.ExperimentalUuidApi

@OptIn(ExperimentalUuidApi::class)
internal class BluetoothRepository(
    private val bluetoothManager: BluetoothManager,
    private val logger: Logger
) : IBluetoothRepository {

    private val peripherals = MutableStateFlow<List<Peripheral>>(emptyList())

    override fun scan(): Flow<PeripheralDeviceState> {
        return bluetoothManager.scan()
            .onEach { advertisement ->
                peripherals.update { currentList ->
                    val isAlreadySaved = currentList.any {
                        it.identifier.toString() == advertisement.identifier.toString()
                    }
                    if (isAlreadySaved) {
                        currentList
                    } else {
                        val newPeripheral = bluetoothManager.createPeripheral(advertisement)
                        currentList + newPeripheral
                    }
                }
            }.map { it.toDomain() }
    }

    override suspend fun connect(uuid: String): Result<Unit> = runCatching {
        bluetoothManager.connect(getPeripheral(uuid))
    }

    override suspend fun disconnect(uuid: String): Result<Unit> = runCatching {
        bluetoothManager.disconnect(getPeripheral(uuid))
    }

    override fun connectionState(uuid: String): Flow<DeviceConnectionState> =
        bluetoothManager.connectionState(getPeripheral(uuid)).map { it.toDomain() }

    override suspend fun sendCommand(
        command: DeviceCommands,
        peripheralUuid: String,
        characteristicState: CharacteristicState
    ): Result<Unit> = runCatching {
        val targetCharacteristic = characteristicOf(
            service = characteristicState.serviceUuid,
            characteristic = characteristicState.characteristicUuid
        )

        bluetoothManager.writeCharacteristic(
            peripheral = getPeripheral(peripheralUuid),
            characteristic = targetCharacteristic,
            value = getPacketToSend(command)
        )
    }.onFailure { e ->
        logger.e("Send Command", "Error sending command: ${e.message}")
    }

    private fun getPacketToSend(command: DeviceCommands): ByteArray = when (command) {
        DeviceCommands.GET_STATUS -> DeviceCommandBuilder.buildGetStatusCmd()
    }

    override fun observePeripherals(
        peripheralUuid: String,
        characteristicState: CharacteristicState
    ): Flow<ByteArray> =
        bluetoothManager.observeCharacteristic(
            peripheral = getPeripheral(peripheralUuid),
            characteristic = characteristicOf(
                service = characteristicState.serviceUuid,
                characteristic = characteristicState.characteristicUuid
            )
        )

    override suspend fun readCharacteristic(
        peripheralUuid: String,
        characteristicState: CharacteristicState
    ): ByteArray =
        bluetoothManager.readCharacteristic(
            peripheral = getPeripheral(peripheralUuid),
            characteristic = characteristicOf(
                service = characteristicState.serviceUuid,
                characteristic = characteristicState.characteristicUuid
            )
        )

    private fun getPeripheral(uuid: String): Peripheral {
        return peripherals.value
            .find { "${it.identifier}".equals(uuid, ignoreCase = true) }
            ?: throw IllegalArgumentException("Peripheral not found")
    }
}
