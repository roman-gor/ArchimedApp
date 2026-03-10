package com.gorman.bluetooth.data

import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.BluetoothPeripheralState
import dev.bluefalcon.BluetoothService
import dev.bluefalcon.ServiceFilter
import dev.bluefalcon.Uuid

internal class BluetoothManager(
    private val bluetoothProvider: BlueFalcon
) {
    val peripherals = bluetoothProvider.peripherals

    val delegates = bluetoothProvider.delegates

    fun scan(filters: List<ServiceFilter>) { bluetoothProvider.scan(filters) }

    fun connect(peripheral: BluetoothPeripheral, autoConnect: Boolean) {
        bluetoothProvider.connect(peripheral, autoConnect)
    }

    fun disconnect(peripheral: BluetoothPeripheral) {
        bluetoothProvider.disconnect(peripheral)
    }

    fun connectionState(peripheral: BluetoothPeripheral): BluetoothPeripheralState {
        return bluetoothProvider.connectionState(peripheral)
    }

    @OptIn(kotlin.uuid.ExperimentalUuidApi::class)
    fun discoverServices(bluetoothPeripheral: BluetoothPeripheral, serviceUUIDs: List<Uuid> = emptyList()) {
        bluetoothProvider.discoverServices(bluetoothPeripheral, serviceUUIDs)
    }

    @OptIn(kotlin.uuid.ExperimentalUuidApi::class)
    fun discoverCharacteristics(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothService: BluetoothService,
        characteristicUUIDs: List<Uuid> = emptyList()
    ) {
        bluetoothProvider.discoverCharacteristics(
            bluetoothPeripheral,
            bluetoothService,
            characteristicUUIDs
        )
    }

    fun notifyCharacteristic(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristic: BluetoothCharacteristic,
        notify: Boolean
    ) {
        bluetoothProvider.notifyCharacteristic(bluetoothPeripheral, bluetoothCharacteristic, notify)
    }

    fun writeCharacteristic(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristic: BluetoothCharacteristic,
        value: ByteArray,
        writeType: Int? = 2
    ) {
        bluetoothProvider.writeCharacteristic(
            bluetoothPeripheral = bluetoothPeripheral,
            bluetoothCharacteristic = bluetoothCharacteristic,
            value = value,
            writeType = writeType
        )
    }

    fun readCharacteristic(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothCharacteristic: BluetoothCharacteristic
    ) {
        bluetoothProvider.readCharacteristic(bluetoothPeripheral, bluetoothCharacteristic)
    }
}
