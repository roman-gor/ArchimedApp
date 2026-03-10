package com.gorman.bluetooth.repository

import com.gorman.bluetooth.constants.DeviceCommands
import com.gorman.bluetooth.constants.UartServiceFilters
import com.gorman.bluetooth.states.CharacteristicState
import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.PeripheralDeviceState
import kotlinx.coroutines.flow.Flow
import kotlin.uuid.ExperimentalUuidApi

@OptIn(ExperimentalUuidApi::class)
interface IBluetoothRepository {
    fun scan(): Flow<PeripheralDeviceState>
    suspend fun connect(uuid: String): Result<Unit>
    suspend fun disconnect(uuid: String): Result<Unit>
    fun connectionState(uuid: String): Flow<DeviceConnectionState>
    suspend fun sendCommand(
        command: DeviceCommands,
        peripheralUuid: String,
        characteristicState: CharacteristicState = CharacteristicState(
            serviceUuid = UartServiceFilters.UART_SERVICE_UUID.value,
            characteristicUuid = UartServiceFilters.UART_CHARACTERISTIC_RX.value
        )
    ): Result<Unit>
    fun observePeripherals(
        peripheralUuid: String,
        characteristicState: CharacteristicState = CharacteristicState(
            serviceUuid = UartServiceFilters.UART_SERVICE_UUID.value,
            characteristicUuid = UartServiceFilters.UART_CHARACTERISTIC_TX.value
        )
    ): Flow<ByteArray>

    suspend fun readCharacteristic(
        peripheralUuid: String,
        characteristicState: CharacteristicState = CharacteristicState(
            serviceUuid = UartServiceFilters.UART_SERVICE_UUID.value,
            characteristicUuid = UartServiceFilters.UART_CHARACTERISTIC_TX.value
        )
    ): ByteArray
}
