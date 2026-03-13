package com.gorman.bluetooth.constants

enum class DeviceCommandByte(val bytes: ByteArray) {
    HEADER_REQUEST(byteArrayOf(0x47.toByte(), 0x14.toByte())),
    HEADER_RESPONSE(byteArrayOf(0x2E.toByte(), 0x69.toByte()))
}

enum class ResponsesTypes(val type: Byte, val responseLength: Int) {
    GET_EXPERIMENTS_LIST(0x55.toByte(), 18),
    GET_EXPERIMENT_DATA(0x54.toByte(), 767),
    GET_EXPERIMENT_ONLINE_DATA(0x84.toByte(), 0),
    GET_SENSORS_IDS(0x82.toByte(), 21),
    GET_SENSORS_VALUES(0x81.toByte(), 0),
    GET_DEVICE_STATUS(0x83.toByte(), 33),
    GET_EXTERNAL_SENSOR_DATA(0x85.toByte(), 6)
}
