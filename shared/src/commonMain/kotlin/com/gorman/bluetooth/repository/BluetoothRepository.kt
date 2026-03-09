package com.gorman.bluetooth.repository

import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.mappers.toDomain
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.mapNotNull

internal class BluetoothRepository(
    private val bluetoothManager: BluetoothManager
) : IBluetoothRepository {
    private val _peripherals = bluetoothManager.peripherals

    override val peripherals = _peripherals.map { peripheralsNative ->
        peripheralsNative.map { it.toDomain() }
    }

    override val delegates = bluetoothManager.delegates

    override fun scan(filters: List<ServiceFilter>) { bluetoothManager.scan(filters) }

    override suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean) {
        val peripheral = getPeripheral(peripheralState)
        bluetoothManager.connect(peripheral, autoConnect)
    }

    override suspend fun disconnect(peripheralState: PeripheralDeviceState) {
        val peripheral = getPeripheral(peripheralState)
        bluetoothManager.disconnect(peripheral)
    }

    private suspend fun getPeripheral(peripheralState: PeripheralDeviceState): BluetoothPeripheral =
        _peripherals.mapNotNull { list -> list.find { it.uuid == peripheralState.uuid } }.first()
}
