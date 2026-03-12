package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Sensors
import kotlinx.datetime.LocalDateTime

data class ExperimentsHistoryDeviceState(
    val experimentNumber: Int = 0,
    val sensors: List<Sensors> = emptyList(),
    val rate: Int = 0,
    val samplesAmount: Int = 10,
    val experimentDateTime: LocalDateTime? = null
)
