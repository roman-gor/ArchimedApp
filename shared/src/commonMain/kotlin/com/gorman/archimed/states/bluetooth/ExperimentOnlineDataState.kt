package com.gorman.archimed.states.bluetooth

data class ExperimentOnlineDataState(
    val currentSample: Int = 0,
    val sensorValue: List<Int> = emptyList()
)
