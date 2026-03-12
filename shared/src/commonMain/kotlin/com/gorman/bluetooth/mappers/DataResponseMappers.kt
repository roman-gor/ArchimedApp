package com.gorman.bluetooth.mappers

import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDeviceState
import com.gorman.archimed.states.bluetooth.OnlineDataDeviceState
import com.gorman.archimed.states.bluetooth.SingleExperimentDeviceState
import com.gorman.archimed.states.bluetooth.StatusDeviceState
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.constants.Sensors
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.bluetooth.parsers.toUnsignedInt
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.LocalTime

fun DeviceResponse.Status.toUiState(): StatusDeviceState =
    StatusDeviceState(
        experimentsInMemory = experimentsInMemory.toUnsignedInt(),
        batteryLevel = battery.toUnsignedInt(),
        memory = memory.toUnsignedInt()
    )

fun DeviceResponse.OnlineData.toUiState(): OnlineDataDeviceState =
    OnlineDataDeviceState(
        currentSample = currentSample,
        sensorValue = getSensorsValues(sensorsVal)
    )

fun DeviceResponse.DownloadInformation.toUiState(sensorsType: SensorType?): ExperimentsHistoryDeviceState =
    ExperimentsHistoryDeviceState(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensors = sensor.toSensorsList(sensorsType?.sensors),
        rate = getRate(rate.toUnsignedInt()),
        samplesAmount = samples,
        experimentDateTime = getDateTime(
            day = day.toUnsignedInt(),
            month = month.toUnsignedInt(),
            year = year.toUnsignedInt(),
            hour = hour.toUnsignedInt(),
            minute = minute.toUnsignedInt(),
            second = sec.toUnsignedInt()
        )
    )

fun DeviceResponse.DownloadData.toUiState(sensorsType: SensorType?): SingleExperimentDeviceState =
    SingleExperimentDeviceState(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensors = sensor.toSensorsList(sensorsType?.sensors),
        rate = getRate(rate.toUnsignedInt()),
        samples = samples,
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

fun Int.toSensorsList(allowedSensors: List<Sensors>?): List<Sensors> {
    val byte0 = (this shr 8) and 0xFF
    val byte1 = this and 0xFF

    return allowedSensors?.filter { sensor ->
        when (sensor.position) {
            0 -> (byte0 and sensor.byteCode.toInt()) != 0
            1 -> (byte1 and sensor.byteCode.toInt()) != 0
            else -> false
        }
    } ?: emptyList()
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
