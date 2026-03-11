package com.gorman.archimed.states.bluetooth

sealed interface BluetoothUiEvent {
    data class OnConnect(val uuid: String?) : BluetoothUiEvent
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent
    data object OnScan : BluetoothUiEvent
    data class OnSendCommand(val command: DeviceCommand) : BluetoothUiEvent

    enum class DeviceCommand {
        GET_STATUS,
        START_LOGGING,
        STOP_LOGGING,
        GET_ALL_SENSORS_ID,
        GET_SENSORS_VALUES,
        GET_DOWNLOADED_STORE_DATA,
        GET_DOWNLOADED_INFO,
        SEND_NEXT_DOWNLOAD,
        RESEND_PREV_DOWNLOAD,
        CLEAR_ALL_SAMPLES_MEMORY,
        TERMINATE_DOWNLOADING,
        DELETE_LAST_RECORDING,
        SET_DATE_TIME
    }
}
