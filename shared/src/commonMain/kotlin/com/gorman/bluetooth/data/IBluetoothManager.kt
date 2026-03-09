package com.gorman.bluetooth.data

import com.gorman.bluetooth.states.PeripheralConnectingState
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.Flow

interface IBluetoothManager {
    val peripherals: Flow<List<PeripheralDeviceState>>

    fun scan(filters: List<ServiceFilter> = emptyList())
    suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean = false)
    suspend fun disconnect(peripheralState: PeripheralDeviceState)
    fun connectionState(peripheral: PeripheralDeviceState): Flow<PeripheralConnectingState>
}
