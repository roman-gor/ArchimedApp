package com.gorman.bluetooth.states

import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDeviceState
import com.gorman.archimed.states.bluetooth.OnlineDataDeviceState
import com.gorman.archimed.states.bluetooth.SingleExperimentDeviceState
import com.gorman.archimed.states.bluetooth.StatusDeviceState
import com.gorman.bluetooth.constants.DeviceType

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean? = null,
    val selectedDeviceId: String? = null,
    val selectedDeviceType: DeviceType? = DeviceType.IDLE,
    val statusDeviceData: StatusDeviceState = StatusDeviceState(),
    val experimentsHistoryDeviceState: List<ExperimentsHistoryDeviceState> = emptyList(),
    val onlineDataDeviceState: OnlineDataDeviceState = OnlineDataDeviceState(),
    val singleExperimentDeviceState: SingleExperimentDeviceState = SingleExperimentDeviceState()
)
