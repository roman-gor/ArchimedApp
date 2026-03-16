package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.SensorType

data class ExperimentOnlineData(
    val currentSample: Short = 0,
    val sensorsData: Map<SensorType, List<Double>> = mapOf()
)
