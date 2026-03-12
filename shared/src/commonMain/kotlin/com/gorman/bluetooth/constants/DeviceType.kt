package com.gorman.bluetooth.constants

enum class DeviceType(val sensorType: SensorType?, val byte: Byte?) {
    ECOLOGY(SensorType.ECOLOGY_SENS, 0xA5.toByte()),
    PHYSICS(SensorType.PHYSICS_SENS, 0xA3.toByte()),
    BIOLOGY(SensorType.BIOLOGY_SENS, 0xA1.toByte()),
    PHYSIOLOGY(SensorType.PHYSIOLOGY_SENS, 0xA4.toByte()),
    UNKNOWN(null, null)
}

//TODO(Make this class to define type of device
enum class ArchimedesVersion(val byte: Byte) {

}

enum class Rates(val byte: Byte) {
    RATE_1(0x02.toByte()),
    RATE_10(0x03.toByte()),
    RATE_100(0x04.toByte())
}

enum class Samples(val byte: Byte) {
    SAMPLE_1(0x02.toByte()),
    SAMPLE_10(0x03.toByte()),
    SAMPLE_100(0x04.toByte())
}
