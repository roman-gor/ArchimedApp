package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import kotlinx.datetime.LocalDateTime

data class StatusDeviceData(
    val archimedesVersion: DeviceType = DeviceType.UNKNOWN,
    val experimentsInMemory: Int = 0,
    val lastUsedSensorsType: List<SensorType> = emptyList(),
    val lastSamplesRates: Rates? = null,
    val lastSamplesCount: Samples? = null,
    val dateTime: LocalDateTime? = null,
    val batteryLevel: Int = 0,
    val memoryUsed: Int = 0,
    val externalAnalogSensor: SensorType = SensorType.UNKNOWN
)
