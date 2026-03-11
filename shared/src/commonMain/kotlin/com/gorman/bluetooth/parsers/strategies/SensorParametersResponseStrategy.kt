package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.toUnsignedInt

internal class SensorParametersResponseStrategy : DeviceResponseStrategy {
    override val responseCode = 0x82.toByte()
    private val expectedLength = 21

    override fun parse(bytes: ByteArray): DeviceResponse? {
        if (!isChecksumValid(bytes, expectedLength) || bytes.size < 21) return null

        return DeviceResponse.SensorParams(
            sensorId = bytes.copyOfRange(3, 19),
            externalId = bytes[19].toUnsignedInt()
        )
    }
}
