package com.gorman.archimed.states.bluetooth

data class StatusDeviceState(
    val experimentsInMemory: Int = 0,
    val batteryLevel: Int = 0,
    val memory: Int = 0
)
