package com.gorman.bluetooth.states

data class EnhancedBluetoothPeripheral(
    val connected: PeripheralConnectingState,
    val peripheral: PeripheralDeviceState,
    val updateCount: Long = 0,
    val mtuStatus: String? = null
)
