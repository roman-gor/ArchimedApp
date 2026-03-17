package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.constants.getSensorTypeFromId
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.logger.Logger

internal class SensorsIdParametersResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_SENSORS_IDS.type
    private val expectedLength = ResponsesTypes.GET_SENSORS_IDS.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength) || bytes.size < 21) {
            return DeviceResponse.Unknown(
                bytes[2],
                bytes.toList()
            )
        }

        logger.d("DDDD", "${bytes.copyOfRange(3, 19).toList()}")
        val sensorsIdsMap = bytes.copyOfRange(3, 19).associateBy { it.getSensorTypeFromId() }
        val externalSensorPair = bytes[19].getSensorTypeFromId() to bytes[19]

        return DeviceResponse.GetSensorIdParams(
            sensorsIdsMap = sensorsIdsMap,
            externalId = externalSensorPair
        )
    }
}
