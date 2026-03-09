package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.PeripheralConnectingState
import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BluetoothPeripheral
import dev.bluefalcon.BluetoothPeripheralState

fun BluetoothPeripheral.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = uuid
)

fun BluetoothPeripheralState.toDomain(): PeripheralConnectingState = when(this) {
    BluetoothPeripheralState.Connecting -> PeripheralConnectingState.Connecting
    BluetoothPeripheralState.Connected -> PeripheralConnectingState.Connected
    BluetoothPeripheralState.Disconnected -> PeripheralConnectingState.Disconnected
    BluetoothPeripheralState.Disconnecting -> PeripheralConnectingState.Disconnecting
    BluetoothPeripheralState.Unknown -> PeripheralConnectingState.Unknown
}

