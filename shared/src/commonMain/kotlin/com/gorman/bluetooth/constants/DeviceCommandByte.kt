package com.gorman.bluetooth.constants

enum class DeviceCommandByte(val bytes: ByteArray) {
    HEADER_REQUEST(byteArrayOf(0x47.toByte(), 0x14.toByte())),
    HEADER_RESPONSE(byteArrayOf(0x2E.toByte(),0x69.toByte()))
}
