package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Sensors
import kotlinx.datetime.LocalDateTime

data class SingleExperimentDataState(
    val experimentNumber: Int = 0,
    val sensors: List<Sensors> = emptyList(),
    val sampleRate: Int = 0,
    val samplesCount: Int = 0,
    val experimentDateTime: LocalDateTime? = null,
    val experimentData: List<Int> = emptyList()
)
