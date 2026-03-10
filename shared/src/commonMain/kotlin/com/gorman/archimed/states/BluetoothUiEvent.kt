package com.gorman.archimed.states

import com.gorman.bluetooth.constants.DeviceCommands

sealed interface BluetoothUiEvent {
    data class OnConnect(val uuid: String?) : BluetoothUiEvent
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent
    data object OnScan : BluetoothUiEvent
    data class OnSendCommand(val command: DeviceCommands) : BluetoothUiEvent
}
