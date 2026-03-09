package com.gorman.bluetooth.states

data class BluetoothDeviceState(
    val devices: HashMap<String, EnhancedBluetoothPeripheral> = HashMap(),
    val isScanning: Boolean = false,
    val selectedDeviceId: String? = null
)
