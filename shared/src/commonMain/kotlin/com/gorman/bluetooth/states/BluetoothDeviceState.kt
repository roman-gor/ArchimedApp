package com.gorman.bluetooth.states

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean? = null,
    val selectedDeviceId: String? = null
)
