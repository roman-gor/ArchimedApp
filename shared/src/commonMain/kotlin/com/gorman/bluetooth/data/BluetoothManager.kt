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
) : IBluetoothManager {
    override val peripherals = bluetoothProvider.peripherals

    override val delegates = bluetoothProvider.delegates

    override fun scan(filters: List<ServiceFilter>) { bluetoothProvider.scan(filters) }

    override fun connect(peripheral: BluetoothPeripheral, autoConnect: Boolean) {
        bluetoothProvider.connect(peripheral, autoConnect)
    }

    override fun disconnect(peripheral: BluetoothPeripheral) {
        bluetoothProvider.disconnect(peripheral)
    }

    override fun connectionState(peripheral: BluetoothPeripheral): BluetoothPeripheralState {
        return bluetoothProvider.connectionState(peripheral)
    }

    override fun readData(bluetoothPeripheral: BluetoothPeripheral, bluetoothCharacteristic: BluetoothCharacteristic) {
        bluetoothProvider.readCharacteristic(bluetoothPeripheral, bluetoothCharacteristic)
    }

    override fun discoverServices(bluetoothPeripheral: BluetoothPeripheral, serviceUUIDs: List<Uuid>) {
        bluetoothProvider.discoverServices(bluetoothPeripheral, serviceUUIDs)
    }

    override fun discoverCharacteristics(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothService: BluetoothService,
        characteristicUUIDs: List<Uuid>
    ) {
        bluetoothProvider.discoverCharacteristics(
            bluetoothPeripheral,
            bluetoothService,
            characteristicUUIDs
        )
    }
}
