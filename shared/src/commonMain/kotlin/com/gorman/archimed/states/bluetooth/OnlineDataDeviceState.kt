package com.gorman.archimed.states.bluetooth

data class OnlineDataDeviceState(
    val currentSample: Int = 0,
    val sensorValue: List<Int> = emptyList()
)
