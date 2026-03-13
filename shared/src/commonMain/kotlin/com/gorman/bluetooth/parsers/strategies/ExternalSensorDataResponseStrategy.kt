package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy

internal class ExternalSensorDataResponseStrategy : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_EXTERNAL_SENSOR_DATA.type
    private val expectedLength = ResponsesTypes.GET_EXTERNAL_SENSOR_DATA.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) {
            DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        return DeviceResponse.GetExternalSensorData(
            externalAnalogSensor1 = bytes[3],
            externalAnalogSensor2 = bytes[4]
        )
    }

}
