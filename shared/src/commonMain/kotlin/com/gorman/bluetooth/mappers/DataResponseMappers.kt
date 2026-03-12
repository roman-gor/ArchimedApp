package com.gorman.bluetooth.mappers

import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDataState
import com.gorman.archimed.states.bluetooth.ExperimentOnlineDataState
import com.gorman.archimed.states.bluetooth.SingleExperimentDataState
import com.gorman.archimed.states.bluetooth.StatusDeviceDataState
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.toUnsignedInt
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.LocalTime

fun DeviceResponse.StatusDeviceData.toUiState(): StatusDeviceDataState =
    StatusDeviceDataState(
        experimentsInMemory = experimentsInMemory.toUnsignedInt(),
        batteryLevel = batteryLevel.toUnsignedInt(),
        memory = freeMemory.toUnsignedInt()
    )

fun DeviceResponse.ExperimentOnlineData.toUiState(): ExperimentOnlineDataState =
    ExperimentOnlineDataState(
        currentSample = currentSample.toInt(),
        sensorValue = getSensorsValues(sensorsVal)
    )

fun DeviceResponse.GetExperimentsList.toUiState(availableSensors: List<Short>): ExperimentsHistoryDataState =
    ExperimentsHistoryDataState(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensors = sensor.toSensorsList(availableSensors),
        sampleRate = getRate(rate.toUnsignedInt()),
        samplesCount = samples.toInt(),
        experimentDateTime = getDateTime(
            day = day.toUnsignedInt(),
            month = month.toUnsignedInt(),
            year = year.toUnsignedInt(),
            hour = hour.toUnsignedInt(),
            minute = minute.toUnsignedInt(),
            second = sec.toUnsignedInt()
        )
    )

fun DeviceResponse.GetExperimentData.toUiState(availableSensors: List<Short>): SingleExperimentDataState =
    SingleExperimentDataState(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensors = sensorType.toShort().toSensorsList(availableSensors),
        sampleRate = getRate(sampleRate.toUnsignedInt()),
        samplesCount = samplesCount.toInt(),
        experimentDateTime = getDateTime(
            day = day.toUnsignedInt(),
            month = month.toUnsignedInt(),
            year = year.toUnsignedInt(),
            hour = hour.toUnsignedInt(),
            minute = minute.toUnsignedInt(),
            second = sec.toUnsignedInt()
        ),
        experimentData = downloadAry.map { it.toUnsignedInt() }.toList()
    )

private fun Short.toSensorsList(availableSensors: List<Short>): List<SensorType> {
    val activeSensors = mutableListOf<SensorType>()

    val byte0 = (this.toInt() shr 8) and 0xFF
    val byte1 = this.toInt() and 0xFF

    for (index in 0..15) {
        val isActive = if (index < 8) {
            (byte0 and (1 shl index)) != 0
        } else {
            val bitPosition = index - 8
            (byte1 and (1 shl bitPosition)) != 0
        }

        if (isActive) {
            val sensorId = availableSensors.getOrNull(index) ?: 0

            if (sensorId != 0.toShort()) {
                val sensorEnum = SensorType.entries.find { it.value == sensorId }

                if (sensorEnum != null) {
                    activeSensors.add(sensorEnum)
                }
            }
        }
    }
    return activeSensors
}

private fun getRate(rate: Int): Int = when (rate) {
    1 -> 1
    2 -> 10
    else -> rate
}

private fun getDateTime(
    day: Int,
    month: Int,
    year: Int,
    hour: Int,
    minute: Int,
    second: Int
): LocalDateTime? {
    val fullYear = if (year < 100) 2000 + year else year

    val safeMonth = month.coerceIn(1, 12)
    val safeDay = day.coerceIn(1, 31)
    val safeHour = hour.coerceIn(0, 23)
    val safeMinute = minute.coerceIn(0, 59)
    val safeSecond = second.coerceIn(0, 59)

    return runCatching {
        val date = LocalDate(year = fullYear, month = safeMonth, day = safeDay)
        val time = LocalTime(hour = safeHour, minute = safeMinute, second = safeSecond)
        LocalDateTime(date, time)
    }.onFailure {
        LocalDateTime(LocalDate(2000, 1, 1), LocalTime(0, 0, 0))
    }.getOrNull()
}

private fun getSensorsValues(sensorsArray: ByteArray): List<Int> {
    val parsedList = mutableListOf<Int>()

    for (i in 0 until sensorsArray.size - 1 step 2) {
        val msb = sensorsArray[i].toInt() and 0xFF
        val lsb = sensorsArray[i + 1].toInt() and 0xFF

        val combined = (msb shl 8) or lsb

        parsedList.add(combined.toShort().toInt())
    }
    return parsedList.toList()
}
