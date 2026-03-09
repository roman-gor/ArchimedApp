package com.gorman.bluetooth.states

import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothCharacteristicDescriptor
import dev.bluefalcon.BluetoothPeripheral

sealed interface DeviceEvent {
    data class OnDeviceConnected(val macId: String) : DeviceEvent
    data class OnDeviceDisconnected(val macId: String) : DeviceEvent
    data class OnServicesDiscovered(val macId: String, val peripheral: BluetoothPeripheral) : DeviceEvent
    data class OnDescriptorRead(
        val macId: String,
        val descriptor: BluetoothCharacteristicDescriptor
    ) : DeviceEvent
    data class OnWriteCharacteristicResult(
        val macId: String,
        val characteristic: BluetoothCharacteristic,
        val success: Boolean
    ) : DeviceEvent
}
