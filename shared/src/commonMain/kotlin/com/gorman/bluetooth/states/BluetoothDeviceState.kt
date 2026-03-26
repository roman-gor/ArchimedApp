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
    val isScanning: Boolean = false,
    @SerialName("isExperimentsHistoryLoading")
    val isExperimentsHistoryLoading: Boolean = false,
    @SerialName("isExperimentDataLoading")
    val isExperimentDataLoading: Boolean = false,
    @SerialName("isOnlineDataLoading")
    val isOnlineDataLoading: Boolean = false,
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
