package com.gorman.bluetooth.models

import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothCharacteristicDescriptor
import dev.bluefalcon.BluetoothPeripheral

sealed interface DeviceEvent {
    data class OnDeviceConnected(val uuid: String) : DeviceEvent
    data class OnDeviceDisconnected(val uuid: String) : DeviceEvent
    data class OnServicesDiscovered(val peripheral: BluetoothPeripheral) : DeviceEvent
    data class OnCharacteristicsDiscovered(val peripheral: BluetoothPeripheral) : DeviceEvent
    data class OnCharacteristicValueChanged(
        val peripheralUuid: String,
        val characteristicUuid: String,
        val byteArray: ByteArray
    ) : DeviceEvent {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (other == null || this::class != other::class) return false

            other as OnCharacteristicValueChanged

            if (peripheralUuid != other.peripheralUuid) return false
            if (characteristicUuid != other.characteristicUuid) return false
            if (!byteArray.contentEquals(other.byteArray)) return false

            return true
        }

        override fun hashCode(): Int {
            var result = peripheralUuid.hashCode()
            result = 31 * result + characteristicUuid.hashCode()
            result = 31 * result + byteArray.contentHashCode()
            return result
        }
    }

    data class OnDescriptorRead(
        val uuid: String,
        val descriptor: BluetoothCharacteristicDescriptor
    ) : DeviceEvent
    data class OnWriteCharacteristicResult(
        val uuid: String,
        val characteristic: BluetoothCharacteristic,
        val success: Boolean,
        val peripheral: BluetoothPeripheral
    ) : DeviceEvent
}
