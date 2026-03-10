package com.gorman.bluetooth.data

import com.gorman.bluetooth.models.DeviceEvent
import com.gorman.logger.Logger
import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothCharacteristicDescriptor
import dev.bluefalcon.BluetoothPeripheral
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlin.uuid.ExperimentalUuidApi

class BleDelegate(
    private val logger: Logger
) : BlueFalconDelegate {

    private val _events = MutableSharedFlow<DeviceEvent>(extraBufferCapacity = 64)
    val events = _events.asSharedFlow()

    var writeChar: BluetoothCharacteristic? = null
    var readChar: BluetoothCharacteristic? = null

    override fun didConnect(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnDeviceConnected(bluetoothPeripheral.uuid))
    }

    override fun didDisconnect(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnDeviceDisconnected(bluetoothPeripheral.uuid))
    }

    override fun didDiscoverCharacteristics(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnCharacteristicsDiscovered(bluetoothPeripheral))
    }

    @OptIn(ExperimentalUuidApi::class)
    override fun didCharacteristcValueChanged(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristic: BluetoothCharacteristic
    ) {
        logger.d("DELEGATE","!!! BLE_RAW_INCOMING: UUID=${bluetoothCharacteristic.uuid} DATA=${bluetoothCharacteristic.value?.toHexString()}")
        bluetoothCharacteristic.value?.let {
            _events.tryEmit(
                DeviceEvent.OnCharacteristicValueChanged(
                    peripheralUuid = bluetoothPeripheral.uuid,
                    characteristicUuid = bluetoothCharacteristic.uuid.toString(),
                    byteArray = it
                )
            )
        }
    }

    override fun didDiscoverServices(bluetoothPeripheral: BluetoothPeripheral) {
        _events.tryEmit(DeviceEvent.OnServicesDiscovered(bluetoothPeripheral))
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
                success,
                bluetoothPeripheral
            )
        )
    }
}
