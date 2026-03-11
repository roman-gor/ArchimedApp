package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsInt

internal class DownloadDataResponseStrategy : DeviceResponseStrategy {
    override val responseCode = 0x54.toByte()
    private val expectedLength = 767

    override fun parse(bytes: ByteArray): DeviceResponse? {
        if (!isChecksumValid(bytes, expectedLength)) return null

        val endIndex = bytes.size - 1

        return DeviceResponse.DownloadData(
            experimentNumber = bytes[3],
            packetNumber = bytes.read2BytesAsInt(4),
            downloadAry = bytes.copyOfRange(6, endIndex)
        )
    }
}
