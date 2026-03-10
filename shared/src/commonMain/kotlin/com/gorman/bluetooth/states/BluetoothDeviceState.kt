package com.gorman.bluetooth.states

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean = false,
    val selectedDeviceId: String? = null
)
