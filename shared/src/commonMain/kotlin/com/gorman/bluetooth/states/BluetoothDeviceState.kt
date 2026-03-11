package com.gorman.bluetooth.states

import com.gorman.bluetooth.constants.DeviceType

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean? = null,
    val selectedDeviceId: String? = null,
    val selectedDeviceType: DeviceType? = DeviceType.IDLE
)
