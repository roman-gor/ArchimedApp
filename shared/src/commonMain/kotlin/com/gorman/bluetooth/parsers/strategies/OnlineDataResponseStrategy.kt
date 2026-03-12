package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsInt
import com.gorman.bluetooth.parsers.toUnsignedInt
import com.gorman.logger.Logger

internal class OnlineDataResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseCode = 0x84.toByte()

    override fun parse(bytes: ByteArray): DeviceResponse {
        val actualLength = bytes[3].toUnsignedInt()
        if (!isChecksumValid(bytes, actualLength)) return DeviceResponse.Unknown(bytes[2].toInt(), bytes)

        val startIndex = 8
        val endIndex = bytes.size - 1

        val sensorsArray = bytes.copyOfRange(startIndex, endIndex)

        val sensors = byteArrayOf(bytes[4], bytes[5])
        logger.d("SensorsArray", "${bytes.toList()}")

        return DeviceResponse.OnlineData(
            dataLength = bytes[3],
            sensor = sensors,
            currentSample = bytes.read2BytesAsInt(6),
            sensorsVal = sensorsArray
        )
    }
}
