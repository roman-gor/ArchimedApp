package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.ConnectionPeripheralState
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.BluetoothPeripheralState

fun BluetoothPeripheral.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = uuid
)

fun BluetoothPeripheralState.toDomain() = when(this) {
    BluetoothPeripheralState.Connecting -> ConnectionPeripheralState.Connecting
    BluetoothPeripheralState.Connected -> ConnectionPeripheralState.Connected
    BluetoothPeripheralState.Disconnected -> ConnectionPeripheralState.Disconnected
    BluetoothPeripheralState.Disconnecting -> ConnectionPeripheralState.Disconnecting
    BluetoothPeripheralState.Unknown -> ConnectionPeripheralState.Unknown
}
