package com.gorman.bluetooth.constants

enum class DeviceType(val byte: Byte?) {
    ECOLOGY(0xA5.toByte()),
    PHYSICS(0xA3.toByte()),
    BIOLOGY(0xA1.toByte()),
    PHYSIOLOGY(0xA4.toByte()),
    UNKNOWN(null)
}

enum class Rates(val byte: Byte) {
    RATE_1_PER_MIN(0x01.toByte()),
    RATE_1_PER_SEC(0x02.toByte()),
    RATE_10_PER_SEC(0x03.toByte()),
    RATE_100_PER_SEC(0x04.toByte()),
    RATE_20000_PER_SEC(0x05.toByte())
}

enum class Samples(val byte: Byte) {
    SAMPLES_10(0x00.toByte()),
    SAMPLES_100(0x01.toByte()),
    SAMPLES_1000(0x02.toByte()),
    SAMPLES_10000(0x03.toByte())
}
