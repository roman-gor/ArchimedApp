package com.gorman.bluetooth.constants

enum class DeviceType(val byte: Byte?) {
    ECOLOGY(0xA5.toByte()),
    PHYSICS(0xA3.toByte()),
    BIOLOGY(0xA1.toByte()),
    PHYSIOLOGY(0xA4.toByte()),
    UNKNOWN(null);

    companion object {
        fun fromByteCode(byte: Byte): DeviceType? =
            DeviceType.entries.firstOrNull { it.byte == byte }
    }
}

enum class Rates(val byte: Byte) {
    RATE_1_PER_MIN(0x01.toByte()),
    RATE_1_PER_SEC(0x02.toByte()),
    RATE_10_PER_SEC(0x03.toByte()),
    RATE_100_PER_SEC(0x04.toByte()),
    RATE_20000_PER_SEC(0x05.toByte());

    companion object {
        fun fromByte(byte: Byte): Rates? =
            Rates.entries.firstOrNull { it.byte == byte }
    }
}

enum class Samples(val byte: Byte, val count: Short) {
    SAMPLES_10(0x00.toByte(), 10),
    SAMPLES_100(0x01.toByte(), 100),
    SAMPLES_1000(0x02.toByte(), 1000),
    SAMPLES_10000(0x03.toByte(), 10000);

    companion object {
        fun fromCount(count: Short): Samples? =
            Samples.entries.firstOrNull { it.count == count }
    }
}
