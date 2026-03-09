package com.gorman.bluetooth.data

import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.NativeFlow
import dev.bluefalcon.ServiceFilter

internal interface IBluetoothManager {
    val peripherals: NativeFlow<Set<BluetoothPeripheral>>
    val delegates: MutableSet<BlueFalconDelegate>
    fun scan(filters: List<ServiceFilter> = emptyList())
    fun connect(peripheral: BluetoothPeripheral, autoConnect: Boolean = false)
    fun disconnect(peripheral: BluetoothPeripheral)
}
