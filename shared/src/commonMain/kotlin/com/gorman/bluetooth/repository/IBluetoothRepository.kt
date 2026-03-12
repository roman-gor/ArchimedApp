package com.gorman.bluetooth.repository

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.UartServiceFilters
import com.gorman.bluetooth.models.DeviceRequest
import com.gorman.bluetooth.states.CharacteristicState
import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.PeripheralDeviceState
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.StateFlow
import kotlin.uuid.ExperimentalUuidApi

@OptIn(ExperimentalUuidApi::class)
interface IBluetoothRepository {
    val deviceType: StateFlow<DeviceType?>
    fun scan(): Flow<PeripheralDeviceState>
    suspend fun connect(uuid: String): Result<Unit>
    suspend fun disconnect(uuid: String): Result<Unit>
    fun connectionState(uuid: String): Flow<DeviceConnectionState>
    fun setDeviceType(type: DeviceType?)
    suspend fun sendCommand(
        command: DeviceRequest,
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
