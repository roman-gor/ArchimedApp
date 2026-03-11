package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsInt

internal class DownloadInformationResponseStrategy : DeviceResponseStrategy {
    override val responseCode = 0x55.toByte()
    val expectedLength = 18

    override fun parse(bytes: ByteArray): DeviceResponse? {
        if (!isChecksumValid(bytes, expectedLength)) return null

        return DeviceResponse.DownloadInformation(
            experimentNumber = bytes[3],
            sensor = bytes.read2BytesAsInt(4),
            rate = bytes[6],
            samples = bytes.read2BytesAsInt(7),
            day = bytes[9],
            month = bytes[10],
            year = bytes[11],
            hour = bytes[12],
            minute = bytes[13],
            sec = bytes[14],
            extAnalogSensor1 = bytes[15],
            extAnalogSensor2 = bytes[16]
        )
    }
}
