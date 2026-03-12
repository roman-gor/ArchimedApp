package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.SensorType
import kotlinx.datetime.LocalDateTime

data class ExperimentsHistoryDataState(
    val experimentNumber: Int = 0,
    val sensors: List<SensorType> = emptyList(),
    val sampleRate: Int = 0,
    val samplesCount: Int = 10,
    val experimentDateTime: LocalDateTime? = null
)
