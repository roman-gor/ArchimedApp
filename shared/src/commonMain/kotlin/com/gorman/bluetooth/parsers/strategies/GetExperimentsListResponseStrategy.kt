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
            return DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        val dateTime = getDateTime(dateTimeByteArray = bytes.copyOfRange(9,15))

        return DeviceResponse.GetExperimentsData(
            experimentNumber = bytes[3],
            sensors = bytes.read2BytesAsShort(4),
            sampleRate = bytes[6],
            samplesCount = bytes.read2BytesAsShort(7),
            dateTime = dateTime,
            extAnalogSensor1 = bytes[15],
            extAnalogSensor2 = bytes[16],
            isFullHistory = true
        )
    }
}
