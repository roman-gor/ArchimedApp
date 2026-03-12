package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsShort

internal class DownloadInformationResponseStrategy : DeviceResponseStrategy {
    override val responseCode = 0x55.toByte()
    val expectedLength = 18

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (!isChecksumValid(bytes, expectedLength)) return DeviceResponse.Unknown(bytes[2].toShort(), bytes)

        return DeviceResponse.GetExperimentsList(
            experimentNumber = bytes[3],
            sensor = bytes.read2BytesAsShort(4),
            rate = bytes[6],
            samples = bytes.read2BytesAsShort(7),
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
