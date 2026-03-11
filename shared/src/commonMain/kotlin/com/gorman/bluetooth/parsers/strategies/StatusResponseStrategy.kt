package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsInt

internal class StatusResponseStrategy : DeviceResponseStrategy {
    override val responseCode = 0x83.toByte()
    private val expectedLength = 33

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) return DeviceResponse.Unknown(bytes[2].toInt(), bytes)

        return DeviceResponse.Status(
            lastOp = bytes[3],
            archimedesVersion = bytes[4],
            firmwareVersion = bytes.read2BytesAsInt(5),
            labdiscMainMode = bytes[7],
            experimentsInMemory = bytes[8],
            sens = bytes.read2BytesAsInt(9),
            rate = bytes[11],
            samples = bytes[12],
            day = bytes[13],
            month = bytes[14],
            year = bytes[15],
            hour = bytes[16],
            minute = bytes[17],
            seconds = bytes[18],
            battery = bytes[19],
            memory = bytes[20],
            sNYear = bytes[21],
            sNMonth = bytes[22],
            sNNumber = bytes.read2BytesAsInt(23),
            extAnalogSensor = bytes[25],
        )
    }
}
