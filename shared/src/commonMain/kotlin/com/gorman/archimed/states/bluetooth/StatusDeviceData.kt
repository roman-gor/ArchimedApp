package com.gorman.archimed.states.bluetooth

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import kotlinx.datetime.LocalDateTime
import kotlinx.serialization.Serializable

@Serializable
data class StatusDeviceData(
    val archimedesVersion: DeviceType = DeviceType.UNKNOWN,
    val experimentsInMemory: Byte = 0,
    val availableDeviceSensors: List<SensorType> = emptyList(),
    val lastUsedSensorsType: List<SensorType> = emptyList(),
    val lastSamplesRates: Rates? = null,
    val lastSamplesCount: Samples? = null,
    val dateTime: LocalDateTime? = null,
    val batteryLevel: Byte = 0,
    val memoryUsed: Byte = 0,
    val externalAnalogSensor: Byte = 0
)
