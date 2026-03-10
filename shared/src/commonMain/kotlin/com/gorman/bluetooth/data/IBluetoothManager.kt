package com.gorman.bluetooth.data

import dev.bluefalcon.BlueFalconDelegate
import dev.bluefalcon.BluetoothCharacteristic
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.BluetoothPeripheralState
import dev.bluefalcon.BluetoothService
import dev.bluefalcon.NativeFlow
import dev.bluefalcon.ServiceFilter
import dev.bluefalcon.Uuid

internal interface IBluetoothManager {
    val peripherals: NativeFlow<Set<BluetoothPeripheral>>
    val delegates: MutableSet<BlueFalconDelegate>
    fun scan(filters: List<ServiceFilter> = emptyList())
    fun connect(peripheral: BluetoothPeripheral, autoConnect: Boolean = false)
    fun disconnect(peripheral: BluetoothPeripheral)
    fun connectionState(peripheral: BluetoothPeripheral): BluetoothPeripheralState
    fun readData(bluetoothPeripheral: BluetoothPeripheral, bluetoothCharacteristic: BluetoothCharacteristic)
    fun discoverServices(bluetoothPeripheral: BluetoothPeripheral, serviceUUIDs: List<Uuid> = emptyList())
    fun discoverCharacteristics(
        bluetoothPeripheral: BluetoothPeripheral,
        bluetoothService: BluetoothService,
        characteristicUUIDs: List<Uuid> = emptyList()
    )
}
