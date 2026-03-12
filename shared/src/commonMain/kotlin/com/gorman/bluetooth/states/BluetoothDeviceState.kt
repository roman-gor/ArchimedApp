package com.gorman.bluetooth.states

import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDataState
import com.gorman.archimed.states.bluetooth.ExperimentOnlineDataState
import com.gorman.archimed.states.bluetooth.SingleExperimentDataState
import com.gorman.archimed.states.bluetooth.StatusDeviceDataState
import com.gorman.bluetooth.constants.DeviceType

data class BluetoothDeviceState(
    val devices: Map<String, EnhancedBluetoothPeripheral> = mapOf(),
    val isScanning: Boolean? = null,
    val selectedDeviceId: String? = null,
    val selectedDeviceType: DeviceType? = null,

    //TODO(Need to make smth with this states. Change to DeviceResponse type maybe
    // or change name to `data` instead of `state`
    val statusDeviceData: StatusDeviceDataState = StatusDeviceDataState(),
    val experimentsHistoryDataState: List<ExperimentsHistoryDataState> = emptyList(),
    val experimentOnlineDataState: ExperimentOnlineDataState = ExperimentOnlineDataState(),
    val singleExperimentDataState: SingleExperimentDataState = SingleExperimentDataState()
)
