package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.toUnsignedInt

internal class SensorValuesResponseStrategy : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_SENSORS_VALUES.type

    override fun parse(bytes: ByteArray): DeviceResponse {
        val actualLength = bytes[3].toUnsignedInt()
        if (!isChecksumValid(bytes, actualLength)) {
            return DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        val sensorVal = bytes.copyOfRange(4, bytes.size - 1)

        return DeviceResponse.GetSensorValues(
            dataLength = bytes[3],
            sensorsValues = sensorVal.toList()
        )
    }
}
