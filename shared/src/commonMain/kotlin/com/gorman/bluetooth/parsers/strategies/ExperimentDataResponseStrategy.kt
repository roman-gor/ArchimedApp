package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.constants.getSensorsValues
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.getDateTime
import com.gorman.bluetooth.parsers.read2BytesAsShort
import com.gorman.logger.Logger

internal class ExperimentDataResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseType = ResponsesTypes.GET_EXPERIMENT_DATA.type
    private val expectedLength = ResponsesTypes.GET_EXPERIMENT_DATA.responseLength

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (bytes.size != expectedLength || !isChecksumValid(bytes, expectedLength)) {
            logger.e(
                "Download Strategy",
                "Expected $expectedLength bytes, got ${bytes.size}. Buffering should happen in UseCase."
            )
            return DeviceResponse.Unknown(bytes[2], bytes.toList())
        }

        val experimentNumber = bytes[3]
        val packetNumber = bytes.read2BytesAsShort(4)
        val dateTime = getDateTime(dateTimeByteArray = bytes.copyOfRange(11, 17))

        return if (packetNumber == 0.toShort()) {
            DeviceResponse.GetExperimentsData(
                experimentNumber = experimentNumber,
                packetNumber = packetNumber,
                sensors = bytes.read2BytesAsShort(6),
                sampleRate = bytes[8],
                samplesCount = bytes.read2BytesAsShort(9),
                dateTime = dateTime,
                extAnalogSensor1 = bytes[17],
                extAnalogSensor2 = bytes[18],
                sensorsValues = bytes.copyOfRange(19, bytes.size - 1).getSensorsValues(),
                isFullHistory = false
            )
        } else {
            DeviceResponse.GetExperimentsData(
                experimentNumber = experimentNumber,
                packetNumber = packetNumber,
                sensorsValues = bytes.copyOfRange(6, bytes.size - 1).getSensorsValues(),
                isFullHistory = false
            )
        }
    }
}
