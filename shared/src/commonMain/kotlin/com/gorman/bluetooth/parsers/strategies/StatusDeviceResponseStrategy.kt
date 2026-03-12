package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsShort
import com.gorman.bluetooth.parsers.toUnsignedInt

internal class StatusDeviceResponseStrategy : DeviceResponseStrategy {

    //TODO(Define constants for this response codes or move it to interface
    // as `expectedLength` - also constant)
    // in every strategy class
    override val responseCode = 0x83.toByte()
    private val expectedLength = 33

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) return DeviceResponse.Unknown(bytes[2].toShort(), bytes.toList())

        return DeviceResponse.StatusDeviceData(
            lastOperationCode = bytes[3],
            archimedesVersion = DeviceType.entries.firstOrNull { it.byte == bytes[4] } ?: DeviceType.UNKNOWN,
            firmwareVersion = bytes.read2BytesAsShort(5),
            labdiscMainMode = bytes[7],
            experimentsInMemory = bytes[8],
            sensors = bytes.read2BytesAsShort(9),
            sampleRate = bytes[11],
            samplesCount = bytes[12],
            day = bytes[13],
            month = bytes[14],
            year = bytes[15],
            hour = bytes[16],
            minute = bytes[17],
            seconds = bytes[18],
            batteryLevel = bytes[19],
            freeMemory = bytes[20],
            sNYear = bytes[21],
            sNMonth = bytes[22],
            sNNumber = bytes.read2BytesAsShort(23),
            extAnalogSensor = bytes[25],
        )
    }
}
