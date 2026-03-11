package com.gorman.bluetooth.parsers

import com.gorman.bluetooth.constants.HeaderByte
import com.gorman.bluetooth.models.DeviceResponse

interface DeviceResponseStrategy {
    val responseCode: Byte

    fun canParse(bytes: ByteArray): Boolean {
        if (bytes.size < 3) return false

        return bytes[0] == HeaderByte.HEADER_RESPONSE_1.byte &&
            bytes[1] == HeaderByte.HEADER_RESPONSE_2.byte &&
            bytes[2] == responseCode
    }

    fun isChecksumValid(bytes: ByteArray, expectedLength: Int): Boolean {
        if (bytes.size < expectedLength) return false

        var sum = 0
        for (i in 0 until expectedLength) {
            sum += bytes[i].toInt() and 0xFF
        }

        return (sum and 0xFF) == 0
    }

    fun parse(bytes: ByteArray): DeviceResponse?
}
