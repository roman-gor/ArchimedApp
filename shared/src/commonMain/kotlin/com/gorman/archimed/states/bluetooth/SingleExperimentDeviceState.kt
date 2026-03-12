package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Sensors
import kotlinx.datetime.LocalDateTime

data class SingleExperimentDeviceState(
    val experimentNumber: Int = 0,
    val sensors: List<Sensors> = emptyList(),
    val rate: Int = 0,
    val samples: Int = 0,
    val experimentDateTime: LocalDateTime? = null,
    val experimentData: List<Int> = emptyList()
)
