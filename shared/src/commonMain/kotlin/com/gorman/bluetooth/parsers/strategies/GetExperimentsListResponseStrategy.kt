package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.getDateTime
import com.gorman.bluetooth.parsers.read2BytesAsShort

internal class GetExperimentsListResponseStrategy : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_EXPERIMENTS_LIST.type
    val expectedLength = ResponsesTypes.GET_EXPERIMENTS_LIST.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) {
            return DeviceResponse.Unknown(bytes[2].toShort(), bytes.toList())
        }

        val dateTime = getDateTime(
            day = bytes[9],
            month = bytes[10],
            year = bytes[11],
            hour = bytes[12],
            minute = bytes[13],
            second = bytes[14],
        )

        return DeviceResponse.GetExperimentsData(
            experimentNumber = bytes[3],
            sensorType = bytes.read2BytesAsShort(4),
            sampleRate = bytes[6],
            samplesCount = bytes.read2BytesAsShort(7),
            dateTime = dateTime,
            extAnalogSensor1 = bytes[15],
            extAnalogSensor2 = bytes[16],
            isFullHistory = true
        )
    }
}
