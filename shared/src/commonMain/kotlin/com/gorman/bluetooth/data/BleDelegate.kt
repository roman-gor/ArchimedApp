package com.gorman.bluetooth.data

import com.gorman.bluetooth.states.DeviceEvent
import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothCharacteristicDescriptor
import dev.bluefalcon.BluetoothPeripheral
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow

class BleDelegate : BlueFalconDelegate {

    private val _events = MutableSharedFlow<DeviceEvent>(extraBufferCapacity = 64)
    val events = _events.asSharedFlow()

    override fun didConnect(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnDeviceConnected(bluetoothPeripheral.uuid))
    }

    override fun didDisconnect(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnDeviceDisconnected(bluetoothPeripheral.uuid))
    }

    override fun didDiscoverCharacteristics(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(
            DeviceEvent.OnServicesDiscovered(bluetoothPeripheral.uuid, bluetoothPeripheral)
        )
    }

    override fun didDiscoverServices(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(
            DeviceEvent.OnServicesDiscovered(bluetoothPeripheral.uuid, bluetoothPeripheral)
        )
    }

    override fun didReadDescriptor(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristicDescriptor: BluetoothCharacteristicDescriptor
    ) {
        _events.tryEmit(
            DeviceEvent.OnDescriptorRead(
                bluetoothPeripheral.uuid,
                bluetoothCharacteristicDescriptor
            )
        )
    }

    override fun didWriteCharacteristic(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristic: BluetoothCharacteristic,
        success: Boolean
    ) {
        _events.tryEmit(
            DeviceEvent.OnWriteCharacteristicResult(
                bluetoothPeripheral.uuid,
                bluetoothCharacteristic,
                success
            )
        )
    }
}
