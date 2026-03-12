package com.gorman.bluetooth.models

import com.gorman.bluetooth.constants.DeviceType

sealed interface DeviceResponse {
    data class StatusDeviceData(
        val lastOperationCode: Byte,
        val archimedesVersion: DeviceType = DeviceType.UNKNOWN,
        val firmwareVersion: Short,
        val labdiscMainMode: Byte,
        val experimentsInMemory: Byte,
        val sensors: Short,
        val sampleRate: Byte,
        val samplesCount: Byte,

        //TODO(Unite to LocalDateTime)
        val day: Byte,
        val month: Byte,
        val year: Byte,
        val hour: Byte,
        val minute: Byte,
        val seconds: Byte,

        //val dateTime: LocalDateTime? = null,

        val batteryLevel: Byte,
        val freeMemory: Byte,
        val sNYear: Byte,
        val sNMonth: Byte,
        val sNNumber: Short,
        val extAnalogSensor: Byte,
        val void: ByteArray = byteArrayOf()
    ) : DeviceResponse {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            return void.contentEquals((other as StatusDeviceData).void)
        }
        override fun hashCode(): Int = void.contentHashCode()
    }

    data class ExperimentOnlineData(
        val dataLength: Byte = 0,

        //TODO(Make Map with Sensor type and sensor value)
        val sensor: ByteArray,
        val sensorsVal: ByteArray,

        val currentSample: Short
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorsVal.contentEquals(other.sensorsVal)
        override fun hashCode() = sensorsVal.contentHashCode()
    }

    data class GetExperimentData(
        val experimentNumber: Byte = 0,
        val packetNumber: Short = 0,

        //TODO(Change type to SensorType)
        val sensorType: Int = 0,

        val sampleRate: Byte = 0,
        val samplesCount: Short = 0,

        //TODO(Unite to LocalDateTime)
        val day: Byte = 0,
        val month: Byte = 0,
        val year: Byte = 0,
        val hour: Byte = 0,
        val minute: Byte = 0,
        val sec: Byte = 0,
        //

        val extAnalogSensor1: Byte = 0,
        val extAnalogSensor2: Byte = 0,
        val downloadAry: ByteArray = byteArrayOf()
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && downloadAry.contentEquals(other.downloadAry)
        override fun hashCode() = downloadAry.contentHashCode()
    }

    //TODO(Reuse these both models in strategies)
    data class GetExperimentsList(
        val experimentNumber: Byte = 0,
        val sensor: Short = 0,
        val rate: Byte = 0,
        val samples: Short = 0,
        val day: Byte = 0,
        val month: Byte = 0,
        val year: Byte = 0,
        val hour: Byte = 0,
        val minute: Byte = 0,
        val sec: Byte = 0,
        val extAnalogSensor1: Byte = 0,
        val extAnalogSensor2: Byte = 0
    ) : DeviceResponse

    data class GetSensorValues(
        val dataLength: Byte,
        val sensorVal: ByteArray
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorVal.contentEquals(other.sensorVal)
        override fun hashCode() = sensorVal.contentHashCode()
    }

    //TODO(Get this response after success connection and define current sensors types)
    data class GetSensorIdParams(
        //TODO(Create mapOf for holding Sensor Id to Sensor Type)
        val sensorId: ByteArray,
        val externalId: Byte
    ) : DeviceResponse {
        override fun equals(other: Any?) = this === other && sensorId.contentEquals(other.sensorId)
        override fun hashCode() = sensorId.contentHashCode()
    }

    //TODO(Анкноун, он и в Африке Анкноун)
    //TODO(А нет, change name `command` to `type` and in every place where it use as `command`)
    data class Unknown(val type: Short, val rawData: List<Byte>) : DeviceResponse
}
