package com.gorman.bluetooth.mappers

import com.gorman.archimed.states.bluetooth.ExperimentOnlineData
import com.gorman.archimed.states.bluetooth.ExperimentsData
import com.gorman.archimed.states.bluetooth.StatusDeviceData
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.constants.toChartData
import com.gorman.bluetooth.constants.toSensorsList
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.toUnsignedInt
import kotlin.collections.forEachIndexed

fun DeviceResponse.StatusDeviceData.toUiState(availableSensors: List<Short>): StatusDeviceData =
    StatusDeviceData(
        archimedesVersion = archimedesVersion,
        experimentsInMemory = experimentsInMemory.toUnsignedInt(),
        lastUsedSensorsType = lastUsedSensorsType.toSensorsList(availableSensors),
        lastSamplesRates = Rates.entries.firstOrNull { it.byte == lastSamplesRate },
        lastSamplesCount = Samples.entries.firstOrNull { it.byte == lastSamplesCount },
        dateTime = dateTime,
        batteryLevel = batteryLevel.toUnsignedInt(),
        memoryUsed = memoryUsed.toUnsignedInt(),
        externalAnalogSensor = externalAnalogSensor
    )

fun DeviceResponse.ExperimentOnlineData.toUiState(availableSensors: List<Short>): ExperimentOnlineData {
    val sensorsData = mutableMapOf<SensorType, Double>()
    val sensors = sensorType.toSensorsList(availableSensors)
    sensors.forEachIndexed { index, sensorType ->
        val value = sensorsValues[index] * sensorType.multiplier
        val roundedValue = kotlin.math.round(value * 100.0) / 100.0
        sensorsData[sensorType] = roundedValue
    }

    return ExperimentOnlineData(
        currentSample = currentSample.toInt(),
        sensorsData = sensorsData
    )
}

fun DeviceResponse.GetExperimentsData.toUiState(
    availableSensors: List<Short>,
    knownSensors: List<SensorType> = emptyList()
): ExperimentsData {
    val sensors = if (packetNumber == 0.toShort()) {
        sensorType.toSensorsList(availableSensors)
    } else {
        knownSensors
    }

    return ExperimentsData(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensorsData = sensorsValues.toChartData(sensors),
        sampleRate = Rates.entries.firstOrNull { it.byte == sampleRate },
        samplesCount = Samples.entries.firstOrNull { it.count == samplesCount },
        experimentDateTime = dateTime,
        activeSensors = sensors
    )
}
