package com.gorman.bluetooth.data

import com.gorman.bluetooth.mappers.toDomain
import com.gorman.bluetooth.states.PeripheralConnectingState
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.mapNotNull

internal class BluetoothManager (
    private val blueFalcon: BlueFalcon,
    private val logger: Logger
): IBluetoothManager {

    override val peripherals = blueFalcon.peripherals.map { peripheralsNative ->
        peripheralsNative.map { it.toDomain() }
    }

    private val _peripherals = blueFalcon.peripherals

    override fun scan(filters: List<ServiceFilter>) { blueFalcon.scan(filters) }

    override suspend fun connect(peripheralState: PeripheralDeviceState, autoConnect: Boolean) {
        val peripheral = _peripherals.mapNotNull { list ->
            list.find { it.uuid == peripheralState.uuid }
        }.first()

        blueFalcon.connect(peripheral, autoConnect)
    }

    override suspend fun disconnect(peripheralState: PeripheralDeviceState) {
        val peripheral = _peripherals.mapNotNull { list ->
            list.find { it.uuid == peripheralState.uuid }
        }.first()

        blueFalcon.disconnect(peripheral)
    }

    override fun connectionState(peripheral: PeripheralDeviceState): Flow<PeripheralConnectingState> {
        return _peripherals
            .map { list ->
                list.find { it.uuid == peripheral.uuid }
            }
            .map { nativePeripheral ->
                logger.d("Start", "Started connection state")
                if (nativePeripheral != null) {
                    blueFalcon.connectionState(nativePeripheral).toDomain()
                } else {
                    PeripheralConnectingState.Disconnected
                }
            }
            .distinctUntilChanged()
    }
}
