package com.gorman.bluetooth.repository

import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.mappers.toDomain
import com.gorman.bluetooth.states.DeviceEvent
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

internal class BluetoothRepository(
    private val bluetoothManager: BluetoothManager,
    private val delegate: BleDelegate
) : IBluetoothRepository {
    private val _peripherals = bluetoothManager.peripherals

    override val peripherals = _peripherals.map { peripheralsNative ->
        peripheralsNative.map { it.toDomain() }
    }

    override val delegates = bluetoothManager.delegates

    override fun scan(filters: List<ServiceFilter>) { bluetoothManager.scan(filters) }

    override suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean) {
        val peripheral = getPeripheral(peripheralState)
        peripheral?.let { bluetoothManager.connect(it, autoConnect) }
    }

    override suspend fun disconnect(peripheralState: PeripheralDeviceState) {
        val peripheral = getPeripheral(peripheralState)
        peripheral?.let { bluetoothManager.disconnect(it) }
    }

    override fun deviceEvents(): SharedFlow<DeviceEvent> = delegate.events

    private suspend fun getPeripheral(peripheralState: PeripheralDeviceState): BluetoothPeripheral? {
        val currentList = _peripherals.first()
        return currentList.find { it.uuid == peripheralState.uuid }
    }
}
