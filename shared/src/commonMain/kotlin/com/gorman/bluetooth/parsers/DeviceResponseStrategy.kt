package com.gorman.bluetooth.parsers

import com.gorman.bluetooth.constants.DeviceCommandByte
import com.gorman.bluetooth.models.DeviceResponse

interface DeviceResponseStrategy {
    val responseType: Byte

    fun canParse(bytes: ByteArray): Boolean {
        if (bytes.size < 3) return false

        return byteArrayOf(bytes[0], bytes[1])
            .contentEquals(DeviceCommandByte.HEADER_RESPONSE.bytes) &&
            bytes[2] == responseType
    }

    fun isChecksumValid(bytes: ByteArray, expectedLength: Int): Boolean {
        if (bytes.size < expectedLength) return false

        var sum = 0
        for (i in 0 until expectedLength) {
            sum += bytes[i].toInt() and 0xFF
        }

        return (sum and 0xFF) == 0
    }

    fun parse(bytes: ByteArray): DeviceResponse
}
