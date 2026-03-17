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
import kotlin.collections.forEachIndexed

fun DeviceResponse.StatusDeviceData.toUiState(availableSensors: List<Byte>): StatusDeviceData =
    StatusDeviceData(
        archimedesVersion = archimedesVersion,
        experimentsInMemory = experimentsInMemory,
        lastUsedSensorsType = lastUsedSensors.toSensorsList(availableSensors),
        lastSamplesRates = Rates.entries.firstOrNull { it.byte == lastSamplesRate },
        lastSamplesCount = Samples.entries.firstOrNull { it.byte == lastSamplesCount },
        dateTime = dateTime,
        batteryLevel = batteryLevel,
        memoryUsed = memoryUsed,
        externalAnalogSensor = externalAnalogSensor
    )

fun DeviceResponse.ExperimentOnlineData.toUiState(availableSensors: List<Byte>): ExperimentOnlineData {
    val sensorsData = mutableMapOf<SensorType, Double>()
    val sensors = sensors.toSensorsList(availableSensors)
    sensors.forEachIndexed { index, sensorType ->
        val value = sensorsValues[index] * sensorType.multiplier
        val roundedValue = kotlin.math.round(value * 100.0) / 100.0
        sensorsData[sensorType] = roundedValue
    }

    return ExperimentOnlineData(
        currentSample = currentSample,
        sensorsData = sensorsData
    )
}

fun DeviceResponse.GetExperimentsData.toUiState(
    availableSensors: List<Byte>,
    knownSensors: List<SensorType> = emptyList()
): ExperimentsData {
    val sensors = if (packetNumber == 0.toShort()) {
        sensors.toSensorsList(availableSensors)
    } else {
        knownSensors
    }

    return ExperimentsData(
        experimentNumber = experimentNumber,
        sensorsData = sensorsValues.toChartData(sensors),
        sampleRate = Rates.fromByte(sampleRate),
        samplesCount = Samples.fromCount(samplesCount),
        experimentDateTime = dateTime,
        activeSensors = sensors
    )
}
