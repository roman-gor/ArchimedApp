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
        val lastUsedSensors: Short,
        val lastSamplesRate: Byte,
        val lastSamplesCount: Byte,
        val dateTime: LocalDateTime? = null,
        val batteryLevel: Byte,
        val memoryUsed: Byte,
        val sNYear: Byte,
        val sNMonth: Byte,
        val sNNumber: Short,
        val externalAnalogSensor: Byte = 0,
        val void: List<Byte> = emptyList()
    ) : DeviceResponse

    data class ExperimentOnlineData(
        val dataLength: Byte = 0,
        val sensors: Short = 0,
        val sensorsValues: List<Short>,
        val currentSample: Short
    ) : DeviceResponse

    data class GetExperimentsData(
        val experimentNumber: Byte = 0,
        val packetNumber: Short = 0,
        val sensors: Short = 0,
        val sampleRate: Byte = 0,
        val samplesCount: Short = 0,
        val dateTime: LocalDateTime? = null,
        val extAnalogSensor1: Byte = 0,
        val extAnalogSensor2: Byte = 0,
        val sensorsValues: List<Short> = emptyList(),
        val isFullHistory: Boolean
    ) : DeviceResponse

    data class GetSensorValues(
        val dataLength: Byte,
        val sensorsValues: List<Byte> = emptyList()
    ) : DeviceResponse

    data class GetSensorIdParams(
        val sensorsIdsMap: Map<SensorType, Byte>,
        val externalId: Pair<SensorType, Byte>
    ) : DeviceResponse

    data class GetExternalSensorData(
        val externalAnalogSensor1: Byte = 0,
        val externalAnalogSensor2: Byte = 0
    ) : DeviceResponse

    data class Unknown(val type: Byte, val rawData: List<Byte>) : DeviceResponse
}
