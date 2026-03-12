package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Sensors

sealed interface BluetoothUiEvent {
    data class OnConnect(val uuid: String?) : BluetoothUiEvent
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent
    data object OnScan : BluetoothUiEvent
    data class OnSendCommand(val command: DeviceCommand) : BluetoothUiEvent

    sealed interface DeviceCommand {
        object GetStatus : DeviceCommand
        object StartDefaultLogging : DeviceCommand
        object StopLogging : DeviceCommand
        object GetAllSensorsId : DeviceCommand
        object GetSensorsValues : DeviceCommand
        object GetDownloadedInfo : DeviceCommand
        object SendNextDownload : DeviceCommand
        object ResendPrevDownload : DeviceCommand
        object ClearAllSamplesMemory : DeviceCommand
        object TerminateDownloading : DeviceCommand
        object DeleteLastRecording : DeviceCommand
        object SetCurrentDateTime : DeviceCommand

        data class StartLogging(
            val sensors: List<Sensors>,
            val rate: Int = 0,
            val samples: Int = 0,
            val shouldCalibrate: Boolean = false
        ) : DeviceCommand
        data class GetDownloadedStoreData(val experimentNumber: Int) : DeviceCommand
    }
}
