package com.gorman.bluetooth.models

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.SensorType
import kotlinx.datetime.LocalDateTime

sealed interface DeviceResponse {
    data class StatusDeviceData(
        val lastOperationCode: Byte,
        val archimedesVersion: DeviceType = DeviceType.UNKNOWN,
        val firmwareVersion: Short,
        val labdiscMainMode: Byte,
        val experimentsInMemory: Byte,
        val lastUsedSensorsType: Short,
        val lastSamplesRate: Byte,
        val lastSamplesCount: Byte,
        val dateTime: LocalDateTime? = null,
        val batteryLevel: Byte,
        val memoryUsed: Byte,
        val sNYear: Byte,
        val sNMonth: Byte,
        val sNNumber: Short,
        val externalAnalogSensor: SensorType = SensorType.UNKNOWN,
        val void: List<Byte> = emptyList()
    ) : DeviceResponse

    data class ExperimentOnlineData(
        val dataLength: Byte = 0,
        val sensorType: Short = 0,
        val sensorsValues: List<Int>,
        val currentSample: Short
    ) : DeviceResponse

    data class GetExperimentsData(
        val experimentNumber: Byte = 0,
        val packetNumber: Short = 0,
        val sensorType: Short = 0,
        val sampleRate: Byte = 0,
        val samplesCount: Short = 0,
        val dateTime: LocalDateTime? = null,
        val extAnalogSensor1: Byte = 0,
        val extAnalogSensor2: Byte = 0,
        val sensorsValues: List<Int> = emptyList(),
        val isFullHistory: Boolean
    ) : DeviceResponse

    data class GetSensorValues(
        val dataLength: Byte,
        val sensorsValues: List<Byte> = emptyList()
    ) : DeviceResponse

    data class GetSensorIdParams(
        val sensorsIdsMap: Map<SensorType, Short>,
        val externalId: Pair<SensorType, Short>
    ) : DeviceResponse

    data class Unknown(val type: Short, val rawData: List<Byte>) : DeviceResponse
}
