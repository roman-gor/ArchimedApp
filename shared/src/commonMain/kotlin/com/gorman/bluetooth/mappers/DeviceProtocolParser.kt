package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.models.DeviceResponse

object DeviceProtocolParser {
    private const val HEADER_1 = 0x2E.toByte()
    private const val HEADER_2 = 0x69.toByte()

    fun parse(bytes: ByteArray): DeviceResponse? {
        if (bytes.size < 4 || bytes[0] != HEADER_1 || bytes[1] != HEADER_2) return null
        return when (val command = bytes[2].toInt() and 0xFF) {
            0x83 -> parseStatus(bytes)
            else -> DeviceResponse.Unknown(command, bytes)
        }
    }

    private fun parseStatus(bytes: ByteArray): DeviceResponse.Status? {
        if (!isChecksumValid(bytes)) return null

        return DeviceResponse.Status(
            lastOp = bytes[3].toInt() and 0xFF,
            archimedesVersion = bytes[4].toInt() and 0xFF,
            firmwareVersion = (bytes[5].toInt() and 0xFF) or ((bytes[6].toInt() and 0xFF) shl 8),
            labdiscMainMode = bytes[7].toInt() and 0xFF,
            experimentsInMemory = bytes[8].toInt() and 0xFF,
            sens = (bytes[9].toInt() and 0xFF) or ((bytes[10].toInt() and 0xFF) shl 8),
            rate = bytes[11].toInt() and 0xFF,
            samples = bytes[12].toInt() and 0xFF,
            day = bytes[13].toInt() and 0xFF,
            month = bytes[14].toInt() and 0xFF,
            year = bytes[15].toInt() and 0xFF,
            hour = bytes[16].toInt() and 0xFF,
            minute = bytes[17].toInt() and 0xFF,
            seconds = bytes[18].toInt() and 0xFF,
            battery = bytes[19].toInt() and 0xFF,
            memory = bytes[20].toInt() and 0xFF,
            sNMemory = bytes[21].toInt() and 0xFF,
            sNMonth = bytes[22].toInt() and 0xFF,
            sNNumber = (bytes[23].toInt() and 0xFF) or ((bytes[24].toInt() and 0xFF) shl 8),
            extAnalogSensor = bytes[25].toInt() and 0xFF,
        )
    }

    private fun isChecksumValid(bytes: ByteArray, expectedLength: Int = 33): Boolean {
        if (bytes.size < expectedLength) return false

        var sum = 0
        for (i in 0 until expectedLength - 1) {
            sum += bytes[i].toInt() and 0xFF
        }

        val calculatedCs = sum and 0xFF

        val receivedCs = bytes[expectedLength - 1].toInt() and 0xFF

        return calculatedCs == receivedCs
    }
}
