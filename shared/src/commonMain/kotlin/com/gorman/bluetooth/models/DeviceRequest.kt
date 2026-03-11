package com.gorman.bluetooth.models

import com.gorman.bluetooth.constants.DeviceCommandByte

sealed interface DeviceRequest {
    fun toByteArray(): ByteArray

    data object GetStatus : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x10.toByte())
    }

    data object StartLogging : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x22.toByte())
    }

    data object StopLogging : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x33.toByte())
    }

    data object DownloadAllRecordingInfo : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x45.toByte())
    }

    data object SendNextDownloadingPacket : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x46.toByte())
    }

    data object ResendPrevDownloadingPacket : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x47.toByte())
    }

    data object TerminateDownloading : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x48.toByte())
    }

    data object GetAllSensorsValues : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x55.toByte())
    }

    data object DeleteLastRecording : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x88.toByte())
    }

    data object ClearAllSamplesMemory : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0x99.toByte())
    }

    data object GetAllSensorsId : DeviceRequest {
        override fun toByteArray(): ByteArray = buildBluetoothPacket(commandCode = 0xAA.toByte())
    }

    data class ArchLoggingSetup(
        val sensors: ByteArray,
        val rate: Byte,
        val samples: Byte,
        val sensorsCalibrate: Byte,
        val noUse: ByteArray = ByteArray(8)
    ) : DeviceRequest {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (other == null || this::class != other::class) return false

            other as ArchLoggingSetup

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

    data class DownloadStoreData(val experimentNumber: Byte) : DeviceRequest {
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

    data class SetSnBtName(
        val year: Byte,
        val month: Byte,
        val number: ByteArray
    ) : DeviceRequest {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (other == null || this::class != other::class) return false

            other as SetSnBtName

            return year == other.year &&
                month == other.month &&
                number.contentEquals(other.number)
        }

        override fun hashCode(): Int {
            var result = year.toInt()
            result = 31 * result + month.toInt()
            result = 31 * result + number.contentHashCode()
            return result
        }

        override fun toByteArray(): ByteArray {
            val params = byteArrayOf(year, month) + number
            return buildBluetoothPacket(0x9A.toByte(), params)
        }
    }
}

private fun buildBluetoothPacket(
    commandCode: Byte,
    parameters: ByteArray = byteArrayOf()
): ByteArray {
    val header1 = DeviceCommandByte.HEADER_REQUEST_1.byte
    val header2 = DeviceCommandByte.HEADER_REQUEST_2.byte

    val payload = byteArrayOf(header1, header2, commandCode) + parameters

    val sum = payload.sumOf { it.toInt() and 0xFF }
    val cs = ((0x100 - (sum and 0xFF)) and 0xFF).toByte()

    return payload + cs
}
