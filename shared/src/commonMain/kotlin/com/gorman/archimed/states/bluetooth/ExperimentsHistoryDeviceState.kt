package com.gorman.archimed.states.bluetooth

import kotlinx.datetime.LocalDateTime

data class ExperimentsHistoryDeviceState(
    val experimentNumber: Int = 0,
    val sensorType: Int = 0, // TODO(Make this as enum class SensorType)
    val rate: Int = 0,
    val samplesAmount: Int = 10,
    val experimentDateTime: LocalDateTime? = null
)
