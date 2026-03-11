package com.gorman.bluetooth.models

import com.gorman.bluetooth.constants.DeviceType

sealed interface DeviceResponse {
    data class Status(
        val lastOp: Byte,
        val archimedesVersion: Byte,
        val firmwareVersion: Int,
        val labdiscMainMode: Byte,
        val experimentsInMemory: Byte,
        val sens: Int,
        val rate: Byte,
        val samples: Byte,
        val day: Byte,
        val month: Byte,
        val year: Byte,
        val hour: Byte,
        val minute: Byte,
        val seconds: Byte,
        val battery: Byte,
        val memory: Byte,
        val sNYear: Byte,
        val sNMonth: Byte,
        val sNNumber: Int,
        val extAnalogSensor: Byte,
        val void: ByteArray = byteArrayOf()
    ) : DeviceResponse {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            return void.contentEquals((other as Status).void)
        }
        override fun hashCode(): Int = void.contentHashCode()
        val deviceType = when (archimedesVersion) {
            0xA1.toByte() -> DeviceType.BIOLOGY
            0xA3.toByte() -> DeviceType.PHYSICS
            0xA4.toByte() -> DeviceType.PHYSIOLOGY
            0xA5.toByte() -> DeviceType.ECOLOGY
            else -> DeviceType.IDLE
        }
    }

    data class OnlineData(
        val dataLength: Byte,
        val sensor: ByteArray,
        val currentSample: Int,
        val sensorsVal: ByteArray
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorsVal.contentEquals(other.sensorsVal)
        override fun hashCode() = sensorsVal.contentHashCode()
    }

    data class DownloadData(
        val experimentNumber: Byte,
        val packetNumber: Int,
        val sensor: Int = 0,
        val rate: Byte = 0,
        val samples: Int = 0,
        val day: Byte = 0,
        val month: Byte = 0,
        val year: Byte = 0,
        val hour: Byte = 0,
        val minute: Byte = 0,
        val sec: Byte = 0,
        val extAnalogSensor1: Byte = 0,
        val extAnalogSensor2: Byte = 0,
        val downloadAry: ByteArray
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && downloadAry.contentEquals(other.downloadAry)
        override fun hashCode() = downloadAry.contentHashCode()
    }

    data class DownloadInformation(
        val experimentNumber: Byte,
        val sensor: Int,
        val rate: Byte,
        val samples: Int,
        val day: Byte,
        val month: Byte,
        val year: Byte,
        val hour: Byte,
        val minute: Byte,
        val sec: Byte,
        val extAnalogSensor1: Byte,
        val extAnalogSensor2: Byte
    ) : DeviceResponse

    data class SensorValues(
        val dataLength: Byte,
        val sensorVal: ByteArray
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorVal.contentEquals(other.sensorVal)
        override fun hashCode() = sensorVal.contentHashCode()
    }

    data class SensorParams(
        val sensorId: ByteArray,
        val externalId: Int
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorId.contentEquals(other.sensorId)
        override fun hashCode() = sensorId.contentHashCode()
    }

    data class ExternalSensorInfo(
        val extAnalogSensor1: Int,
        val extAnalogSensor2: Int
    ) : DeviceResponse

    data class Unknown(val command: Int, val rawData: ByteArray) : DeviceResponse {
        override fun equals(
            other: Any?
        ) = this === other && command == other.command && rawData.contentEquals(other.rawData)
        override fun hashCode() = 31 * command + rawData.contentHashCode()
    }
}
