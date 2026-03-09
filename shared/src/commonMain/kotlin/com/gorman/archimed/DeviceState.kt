package com.gorman.archimed

import dev.bluefalcon.BluetoothPeripheral

data class BluetoothDeviceState(
    val devices: HashMap<String, EnhancedBluetoothPeripheral> = HashMap(),
    val isScanning: Boolean = false,
    val selectedDeviceId: String? = null
)

data class EnhancedBluetoothPeripheral(
    val connected: Boolean,
    val peripheral: PeripheralDeviceState,
    val updateCount: Long = 0,
    val mtuStatus: String? = null
)

data class PeripheralDeviceState(
    val name: String? = null,
    val uuid: String? = null
)

fun BluetoothPeripheral.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = uuid
)
