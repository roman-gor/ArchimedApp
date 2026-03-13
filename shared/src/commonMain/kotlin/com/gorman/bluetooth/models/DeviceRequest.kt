package com.gorman.bluetooth.models

import com.gorman.bluetooth.constants.DeviceCommandByte

sealed interface DeviceRequest {
    fun toByteArray(): ByteArray

    data object GetStatus : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x10.toByte())
    }

    data object StartLogging : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x22.toByte())
    }

    data object StopLogging : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x33.toByte())
    }

    data object GetAllExperimentsList : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x45.toByte())
    }

    data object SendNextPacket : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x46.toByte())
    }

    data object ResendPrevPacket : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x47.toByte())
    }

    data object TerminateDownloading : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x48.toByte())
    }

    data object GetAllSensorsValues : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x55.toByte())
    }

    data object DeleteLastRecording : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x88.toByte())
    }

    data object ClearDeviceMemory : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0x99.toByte())
    }

    data object GetAllSensorsId : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(typeCode = 0xAA.toByte())
    }

    data class SetupLoggingParameters(
        val sensors: ByteArray,
        val rate: Byte,
        val samples: Byte,
        val sensorsCalibrate: Byte,
        val noUse: ByteArray = ByteArray(8)
    ) : DeviceRequest {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (other == null || this::class != other::class) return false

            other as SetupLoggingParameters

            return rate == other.rate &&
                samples == other.samples &&
                sensorsCalibrate == other.sensorsCalibrate &&
                sensors.contentEquals(other.sensors) &&
                noUse.contentEquals(other.noUse)
        }

        override fun hashCode(): Int {
            var result = sensors.contentHashCode()
            result = 31 * result + rate.toInt()
            result = 31 * result + samples.toInt()
            result = 31 * result + sensorsCalibrate.toInt()
            result = 31 * result + noUse.contentHashCode()
            return result
        }

        override fun toByteArray(): ByteArray {
            val params = sensors + byteArrayOf(rate, samples, sensorsCalibrate) + noUse
            return buildBluetoothPacket(0x11.toByte(), params)
        }
    }

    data class GetExperimentData(val experimentNumber: Byte) : DeviceRequest {
        override fun toByteArray(): ByteArray {
            val params = byteArrayOf(experimentNumber)
            return buildBluetoothPacket(0x44.toByte(), params)
        }
    }

    data class SetDateTime(
        val day: Byte,
        val month: Byte,
        val year: Byte,
        val hour: Byte,
        val min: Byte,
        val sec: Byte
    ) : DeviceRequest {
        override fun toByteArray(): ByteArray {
            val params = byteArrayOf(day, month, year, hour, min, sec)
            return buildBluetoothPacket(0xCC.toByte(), params)
        }
    }
}

private fun buildBluetoothPacket(
    typeCode: Byte,
    parameters: ByteArray = byteArrayOf()
): ByteArray {
    val header = DeviceCommandByte.HEADER_REQUEST.bytes

    val payload = header + byteArrayOf(typeCode) + parameters

    val sum = payload.sumOf { it.toInt() and 0xFF }
    val cs = ((0x100 - (sum and 0xFF)) and 0xFF).toByte()

    return payload + cs
}
