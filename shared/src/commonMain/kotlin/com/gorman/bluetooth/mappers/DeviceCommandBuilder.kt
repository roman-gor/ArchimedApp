package com.gorman.bluetooth.mappers

object DeviceCommandBuilder {
    private const val HEADER_1 = 0x47.toByte()
    private const val HEADER_2 = 0x14.toByte()

    fun buildGetStatusCmd(): ByteArray {
        val command = 0x10.toByte()
        val payload = byteArrayOf(HEADER_1, HEADER_2, command)
        return buildPacket(payload)
    }

    private fun buildPacket(payload: ByteArray): ByteArray {
        val sum = payload.sumOf { it.toInt() and 0xFF }

        val cs = ((0x100 - (sum and 0xFF)) and 0xFF).toByte()

        return payload + cs
    }
}
