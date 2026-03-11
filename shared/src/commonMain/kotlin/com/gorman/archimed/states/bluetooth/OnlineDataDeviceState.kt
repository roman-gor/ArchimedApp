package com.gorman.archimed.states.bluetooth

data class OnlineDataDeviceState(
    val currentSample: Int = 0,
    val sensorValue: IntArray = intArrayOf()
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as OnlineDataDeviceState

        if (currentSample != other.currentSample) return false
        if (!sensorValue.contentEquals(other.sensorValue)) return false

        return true
    }

    override fun hashCode(): Int {
        var result = currentSample
        result = 31 * result + sensorValue.contentHashCode()
        return result
    }
}
