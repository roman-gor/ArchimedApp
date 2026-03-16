package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import kotlinx.datetime.LocalDateTime

data class ExperimentsData(
    val experimentNumber: Int = 0,
    val sensorsData: Map<SensorType, List<Double>> = mapOf(),
    val sampleRate: Rates? = null,
    val samplesCount: Samples? = null,
    val experimentDateTime: LocalDateTime? = null,
    val activeSensors: List<SensorType> = emptyList()
)
