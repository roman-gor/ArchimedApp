package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.getDateTime
import com.gorman.bluetooth.parsers.read2BytesAsShort

internal class StatusDeviceResponseStrategy : DeviceResponseStrategy {

    override val responseType = ResponsesTypes.GET_DEVICE_STATUS.type
    private val expectedLength = ResponsesTypes.GET_DEVICE_STATUS.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) {
            return DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        val dateTime = getDateTime(dateTimeByteArray = bytes.copyOfRange(13,19))

        return DeviceResponse.StatusDeviceData(
            lastOperationCode = bytes[3],
            archimedesVersion = DeviceType.entries.firstOrNull { it.byte == bytes[4] } ?: DeviceType.UNKNOWN,
            firmwareVersion = bytes.read2BytesAsShort(5),
            labdiscMainMode = bytes[7],
            experimentsInMemory = bytes[8],
            lastUsedSensors = bytes.read2BytesAsShort(9),
            lastSamplesRate = bytes[11],
            lastSamplesCount = bytes[12],
            dateTime = dateTime,
            batteryLevel = bytes[19],
            memoryUsed = bytes[20],
            sNYear = bytes[21],
            sNMonth = bytes[22],
            sNNumber = bytes.read2BytesAsShort(23),
            externalAnalogSensor = bytes[25],
        )
    }
}
