package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.constants.getSensorsValues
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsShort
import com.gorman.bluetooth.parsers.toUnsignedInt
import com.gorman.logger.Logger

internal class ExperimentOnlineDataResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_EXPERIMENT_ONLINE_DATA.type

    override fun parse(bytes: ByteArray): DeviceResponse {
        val actualLength = bytes[3].toUnsignedInt()
        if (!isChecksumValid(bytes, actualLength)) {
            return DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        val startIndex = 8
        val endIndex = bytes.size - 1

        val sensorsArray = bytes.copyOfRange(startIndex, endIndex)
        logger.d("SENSORS IDS", "${sensorsArray.toList()}")

        return DeviceResponse.ExperimentOnlineData(
            dataLength = bytes[3],
            sensors = bytes.read2BytesAsShort(4),
            currentSample = bytes.read2BytesAsShort(6),
            sensorsValues = sensorsArray.getSensorsValues()
        )
    }
}
