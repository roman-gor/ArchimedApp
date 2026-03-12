package com.gorman.bluetooth.constants

enum class DeviceCommandByte(val byte: Byte) {
    HEADER_REQUEST_1(0x47.toByte()),
    HEADER_REQUEST_2(0x14.toByte()),
    HEADER_RESPONSE_1(0x2E.toByte()),
    HEADER_RESPONSE_2(0x69.toByte())
}

val rateSensorsMap = mapOf(
    0x00.toByte() to 1,
    0x01.toByte() to 10,
    0x02.toByte() to 100
)
