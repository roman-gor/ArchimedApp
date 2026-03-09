package com.gorman.bluetooth.data

import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.ServiceFilter

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
}
