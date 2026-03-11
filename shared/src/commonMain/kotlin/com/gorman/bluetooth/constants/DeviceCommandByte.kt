package com.gorman.bluetooth.constants

enum class DeviceCommandByte(val byte: Byte) {
    HEADER_REQUEST_1(0x47.toByte()),
    HEADER_REQUEST_2(0x14.toByte()),
    HEADER_RESPONSE_1(0x2E.toByte()),
    HEADER_RESPONSE_2(0x69.toByte()),
    DOWNLOAD_DATA_BYTE(0x54.toByte())
}
