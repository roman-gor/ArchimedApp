package com.gorman.archimed.states

sealed interface BluetoothUiEvent {
    data class OnConnect(val uuid: String?) : BluetoothUiEvent
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent
    data object OnScan : BluetoothUiEvent
    data class OnSendCommand(val command: DeviceCommand) : BluetoothUiEvent

    enum class DeviceCommand {
        GET_STATUS,
        START_LOGGING,
        GET_ALL_SENSORS_ID,
        GET_SENSORS_VALUES,
        GET_DOWNLOADED_STORE_DATA,
        GET_DOWNLOADED_INFO
    }
}
