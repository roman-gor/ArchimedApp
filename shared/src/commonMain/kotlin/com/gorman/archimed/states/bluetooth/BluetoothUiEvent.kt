package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.Sensors

sealed interface BluetoothUiEvent {
    data class OnConnect(val uuid: String?) : BluetoothUiEvent
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent
    data object OnScan : BluetoothUiEvent
    data class OnSendCommand(val command: DeviceCommand) : BluetoothUiEvent

    sealed interface DeviceCommand {
        object GetStatus : DeviceCommand
        object StartDefaultLogging : DeviceCommand
        data class StartLogging(
            val sensors: List<Sensors>,
            val sampleRate: Rates = Rates.RATE_10,
            val sampleCount: Samples = Samples.SAMPLE_100,
            val shouldCalibrate: Boolean = false
        ) : DeviceCommand
        object StopLogging : DeviceCommand
        object GetAllSensorsId : DeviceCommand
        object GetSensorsValues : DeviceCommand
        object GetExperimentsList : DeviceCommand
        data class GetExperimentData(val experimentNumber: Int) : DeviceCommand
        object SendNextDataPackage : DeviceCommand
        object ResendPrevDataPackage : DeviceCommand
        object ClearDeviceMemory : DeviceCommand
        object TerminateDownloading : DeviceCommand
        object DeleteLastRecording : DeviceCommand
        object SetCurrentDateTime : DeviceCommand
    }
}
