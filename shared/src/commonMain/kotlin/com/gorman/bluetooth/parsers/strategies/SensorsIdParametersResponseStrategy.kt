package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.constants.getSensorTypeFromIndex
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy

internal class SensorsIdParametersResponseStrategy : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_SENSORS_IDS.type
    private val expectedLength = ResponsesTypes.GET_SENSORS_IDS.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength) || bytes.size < 21) {
            return DeviceResponse.Unknown(
                bytes[2].toShort(),
                bytes.toList()
            )
        }

        val sensorsIdsMap = bytes.copyOfRange(3, 19).associate { it.getSensorTypeFromIndex() to it.toShort() }
        val externalSensorPair = bytes[19].getSensorTypeFromIndex() to bytes[19].toShort()

        return DeviceResponse.GetSensorIdParams(
            sensorsIdsMap = sensorsIdsMap,
            externalId = externalSensorPair
        )
    }
}
