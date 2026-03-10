package com.gorman.bluetooth.models

sealed interface DeviceResponse {
    data class Status(
        val lastOp: Int? = null,
        val archimedesVersion: Int? = null,
        val firmwareVersion: Int? = null,
        val labdiscMainMode: Int? = null,
        val experimentsInMemory: Int? = null,
        val sens: Int? = null,
        val rate: Int? = null,
        val samples: Int? = null,
        val day: Int? = null,
        val month: Int? = null,
        val year: Int? = null,
        val hour: Int? = null,
        val minute: Int? = null,
        val seconds: Int? = null,
        val battery: Int? = null,
        val memory: Int? = null,
        val sNMemory: Int? = null,
        val sNMonth: Int? = null,
        val sNNumber: Int? = null,
        val extAnalogSensor: Int? = null,
        val void: Int? = null
    ) : DeviceResponse

    data class Unknown(val command: Int, val rawData: ByteArray) : DeviceResponse {
        override fun equals(other: Any?): Boolean {
            if (this === other) return true
            if (other == null || this::class != other::class) return false

            other as Unknown

            if (command != other.command) return false
            if (!rawData.contentEquals(other.rawData)) return false

            return true
        }

        override fun hashCode(): Int {
            var result = command
            result = 31 * result + rawData.contentHashCode()
            return result
        }
    }
}
