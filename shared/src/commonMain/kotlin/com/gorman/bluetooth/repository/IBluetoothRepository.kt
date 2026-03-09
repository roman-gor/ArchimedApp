package com.gorman.bluetooth.repository

import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.Flow

interface IBluetoothRepository {
    val peripherals: Flow<List<PeripheralDeviceState>>
    val delegates: MutableSet<BlueFalconDelegate>
    fun scan(filters: List<ServiceFilter> = emptyList())
    suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean = false)
    suspend fun disconnect(peripheralState: PeripheralDeviceState)
}
