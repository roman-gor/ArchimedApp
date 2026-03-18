package com.gorman.bluetooth.states

import com.gorman.archimed.states.bluetooth.ExperimentOnlineData
import com.gorman.archimed.states.bluetooth.ExperimentsData
import com.gorman.archimed.states.bluetooth.StatusDeviceData
import com.gorman.bluetooth.constants.DeviceType
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class BluetoothDeviceState(
    @SerialName("devices")
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    @SerialName("isScanning")
    val isScanning: Boolean? = null,
    @SerialName("selectedDeviceId")
    val selectedDeviceId: String? = null,
    @SerialName("selectedDeviceType")
    val selectedDeviceType: DeviceType = DeviceType.UNKNOWN,
    @SerialName("statusDeviceData")
    val statusDeviceData: StatusDeviceData = StatusDeviceData(),
    @SerialName("experimentsHistoryData")
    val experimentsHistoryData: List<ExperimentsData> = emptyList(),
    @SerialName("experimentOnlineData")
    val experimentOnlineData: ExperimentOnlineData = ExperimentOnlineData(),
    @SerialName("experimentData")
    val experimentData: ExperimentsData = ExperimentsData()
)
