package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.toUnsignedInt
import com.gorman.logger.Logger

internal class SensorValuesResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseCode = 0x81.toByte()

    override fun parse(bytes: ByteArray): DeviceResponse? {
        val actualLength = bytes[3].toUnsignedInt()
        if (!isChecksumValid(bytes, actualLength)) {
            logger.e("SensorValues Strategy", "Checksum is not valid")
            return null
        }

        val sensorVal = bytes.copyOfRange(4, bytes.size - 1)

        return DeviceResponse.SensorValues(
            dataLength = bytes[3],
            sensorVal = sensorVal
        )
    }
}
