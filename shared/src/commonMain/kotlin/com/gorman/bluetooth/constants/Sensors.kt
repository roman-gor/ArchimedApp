package com.gorman.bluetooth.constants

enum class Sensors(val position: Int, val byteCode: Byte) {
    AMMETER(0, 0x01.toByte()),
    TEMPERATURE(0, 0x02.toByte()),
    ACCELEROMETER(0, 0x04.toByte()),
    VOLTMETER(1, 0x04.toByte()),
    PRESSURE(1, 0x02.toByte()),
    EXTERNAL_MINI_DIN(1, 0x01.toByte()),
    ILLUMINATION(1, 0x02.toByte()),
    HUMIDITY(0, 0x01.toByte()),
    BNC_CONNECTOR(0, 0x04.toByte()),
    HEART(0, 0x01.toByte()),
    BREATH(0, 0x02.toByte()),
    ACIDITY(0, 0x04.toByte())
}
