package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
sealed interface BluetoothUiEvent {
    @Serializable
    @SerialName("on_connect")
    data class OnConnect(val uuid: String?) : BluetoothUiEvent

    @Serializable
    @SerialName("on_disconnect")
    data class OnDisconnect(val uuid: String?) : BluetoothUiEvent

    @Serializable
    @SerialName("on_start_scan")
    data object OnScan : BluetoothUiEvent

    @Serializable
    @SerialName("on_stop_scan")
    data object OnStopScan : BluetoothUiEvent

    @Serializable
    @SerialName("on_send_command")
    data class OnSendCommand(val command: DeviceCommand) : BluetoothUiEvent

    @Serializable
    sealed interface DeviceCommand {
        @Serializable
        @SerialName("get_status")
        object GetStatus : DeviceCommand

        @Serializable
        @SerialName("start_default_logging")
        object StartDefaultLogging : DeviceCommand

        @Serializable
        @SerialName("start_logging")
        data class StartLogging(
            @SerialName("sensors") val sensors: List<SensorType>,
            @SerialName("sample_rate") val sampleRate: Rates = Rates.RATE_10_PER_SEC,
            @SerialName("sample_count") val sampleCount: Samples = Samples.SAMPLES_100,
            @SerialName("should_calibrate") val shouldCalibrate: Boolean = false
        ) : DeviceCommand

        @Serializable
        @SerialName("stop_logging")
        object StopLogging : DeviceCommand

        @Serializable
        @SerialName("get_all_sensors_id")
        object GetAllSensorsId : DeviceCommand

        @Serializable
        @SerialName("get_sensors_values")
        object GetSensorsValues : DeviceCommand

        @Serializable
        @SerialName("get_experiments_list")
        object GetExperimentsList : DeviceCommand

        @Serializable
        @SerialName("get_experiment_data")
        data class GetExperimentData(val experimentNumber: Int) : DeviceCommand

        @Serializable
        @SerialName("send_next_data_package")
        object SendNextDataPackage : DeviceCommand

        @Serializable
        @SerialName("resend_next_prev_package")
        object ResendPrevDataPackage : DeviceCommand

        @Serializable
        @SerialName("clear_device_memory")
        object ClearDeviceMemory : DeviceCommand

        @Serializable
        @SerialName("terminate_downloading")
        object TerminateDownloading : DeviceCommand

        @Serializable
        @SerialName("delete_last_recording")
        object DeleteLastRecording : DeviceCommand

        @Serializable
        @SerialName("set_current_date_time")
        object SetCurrentDateTime : DeviceCommand

        @Serializable
        @SerialName("get_external_sensors_data")
        object GetExternalSensorsData : DeviceCommand
    }
}
