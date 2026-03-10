package com.gorman.bluetooth.mappers

object DeviceCommandBuilder {
    private const val HEADER_1 = 0x47.toByte()
    private const val HEADER_2 = 0x14.toByte()

    fun buildGetStatusCmd(): ByteArray {
        val command = 0x10.toByte()
        return buildPacket(byteArrayOf(HEADER_1, HEADER_2, command))
    }

    private fun buildPacket(payload: ByteArray): ByteArray {
        var sum = 0
        for (byte in payload) {
            sum += byte.toInt() and 0xFF
        }
        val cs = (sum and 0xFF).toByte()

        return payload + cs
    }
}
