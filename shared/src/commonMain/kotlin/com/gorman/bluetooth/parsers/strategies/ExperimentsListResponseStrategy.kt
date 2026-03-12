package com.gorman.bluetooth.parsers.strategies

import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.read2BytesAsShort
import com.gorman.logger.Logger

internal class ExperimentsListResponseStrategy(
    private val logger: Logger
) : DeviceResponseStrategy {
    override val responseCode = 0x54.toByte()
    private val expectedLength = 767

    override fun parse(bytes: ByteArray): DeviceResponse {
        if (bytes.size != expectedLength || !isChecksumValid(bytes, expectedLength)) {
            logger.e(
                "Download Strategy",
                "Expected $expectedLength bytes, got ${bytes.size}. Buffering should happen in UseCase."
            )
            return DeviceResponse.Unknown(bytes[2].toShort(), bytes)
        }

        val experimentNumber = bytes[3]
        val packetNumber = bytes.read2BytesAsShort(4)

        return if (packetNumber == 0.toShort()) {
            DeviceResponse.GetExperimentData(
                experimentNumber = experimentNumber,
                packetNumber = packetNumber,
                sensorType = bytes.read2BytesAsShort(6),
                sampleRate = bytes[8],
                samplesCount = bytes.read2BytesAsShort(9),
                day = bytes[11],
                month = bytes[12],
                year = bytes[13],
                hour = bytes[14],
                minute = bytes[15],
                sec = bytes[16],
                extAnalogSensor1 = bytes[17],
                extAnalogSensor2 = bytes[18],
                downloadAry = bytes.copyOfRange(19, bytes.size - 1)
            )
        } else {
            DeviceResponse.GetExperimentData(
                experimentNumber = experimentNumber,
                packetNumber = packetNumber,
                downloadAry = bytes.copyOfRange(6, bytes.size - 1)
            )
        }
    }
}
