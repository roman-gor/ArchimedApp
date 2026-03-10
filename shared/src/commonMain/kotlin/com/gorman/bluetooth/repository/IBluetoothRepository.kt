package com.gorman.bluetooth.repository

import com.gorman.bluetooth.constants.DeviceCommands
import com.gorman.bluetooth.models.DeviceEvent
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.states.ConnectionPeripheralState
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.SharedFlow

interface IBluetoothRepository {
    val peripherals: Flow<List<PeripheralDeviceState>>
    val delegates: MutableSet<BlueFalconDelegate>
    val incomingUartMessages: SharedFlow<DeviceResponse?>
    fun scan(filters: List<ServiceFilter> = emptyList())
    suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean = false)
    suspend fun disconnect(peripheralState: PeripheralDeviceState)
    fun deviceEvents(): SharedFlow<DeviceEvent>
    suspend fun connectionState(peripheralState: PeripheralDeviceState): ConnectionPeripheralState?
    fun sendCommand(command: DeviceCommands, peripheralUuid: String)
}
