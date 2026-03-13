package com.gorman.bluetooth.states

import com.gorman.archimed.states.bluetooth.ExperimentOnlineData
import com.gorman.archimed.states.bluetooth.ExperimentsData
import com.gorman.archimed.states.bluetooth.StatusDeviceData
import com.gorman.bluetooth.constants.DeviceType

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean? = null,
    val selectedDeviceId: String? = null,
    val selectedDeviceType: DeviceType = DeviceType.UNKNOWN,
    val statusDeviceData: StatusDeviceData = StatusDeviceData(),
    val experimentsHistoryDataState: List<ExperimentsData> = emptyList(),
    val experimentOnlineData: ExperimentOnlineData = ExperimentOnlineData(),
    val experimentsData: ExperimentsData = ExperimentsData()
)
