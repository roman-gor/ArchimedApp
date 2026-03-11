package com.gorman.bluetooth.mappers

import com.gorman.archimed.states.bluetooth.ExperimentsHistoryDeviceState
import com.gorman.archimed.states.bluetooth.OnlineDataDeviceState
import com.gorman.archimed.states.bluetooth.StatusDeviceState
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
        sensorValue = sensorsVal.map { it.toUnsignedInt() }.toIntArray()
    )

fun DeviceResponse.DownloadInformation.toUiState(): ExperimentsHistoryDeviceState =
    ExperimentsHistoryDeviceState(
        experimentNumber = experimentNumber.toUnsignedInt(),
        sensorType = sensor,
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

private fun getRate(rate: Int): Int = when (rate) {
    2 -> 1
    3 -> 10
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
