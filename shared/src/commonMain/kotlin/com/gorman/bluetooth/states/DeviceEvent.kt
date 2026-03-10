package com.gorman.bluetooth.states

import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothCharacteristicDescriptor
import dev.bluefalcon.BluetoothPeripheral

sealed interface DeviceEvent {
    data class OnDeviceConnected(val uuid: String) : DeviceEvent
    data class OnDeviceDisconnected(val uuid: String) : DeviceEvent
    data class OnServicesDiscovered(val uuid: String, val peripheral: BluetoothPeripheral) : DeviceEvent
    data class OnDescriptorRead(
        val uuid: String,
        val descriptor: BluetoothCharacteristicDescriptor
    ) : DeviceEvent
    data class OnWriteCharacteristicResult(
        val uuid: String,
        val characteristic: BluetoothCharacteristic,
        val success: Boolean
    ) : DeviceEvent
}
