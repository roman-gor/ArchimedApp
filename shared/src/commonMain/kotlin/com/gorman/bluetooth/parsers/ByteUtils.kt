package com.gorman.bluetooth.parsers

import com.gorman.bluetooth.models.DeviceRequest
import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.LocalTime
import kotlinx.datetime.TimeZone
import kotlinx.datetime.number
import kotlinx.datetime.toLocalDateTime
import kotlin.time.Clock
import kotlin.time.Instant

fun Byte.toUnsignedInt(): Int = this.toInt() and 0xFF

fun ByteArray.read2BytesAsShort(startIndex: Int): Short {
    val high = this[startIndex].toUnsignedInt()
    val low = this[startIndex + 1].toUnsignedInt()
    val rawInt = (high shl 8) or low
    return rawInt.toShort()
}

fun getDateTime(dateTimeByteArray: ByteArray): LocalDateTime? {
    if (dateTimeByteArray.size != 6) return null

    val fullYear = if (dateTimeByteArray[2] < 100) {
        2000 + bcdToDec(dateTimeByteArray[2].toUnsignedInt())
    } else {
        bcdToDec(dateTimeByteArray[2].toUnsignedInt())
    }
    val safeDay = bcdToDec(dateTimeByteArray[0].toUnsignedInt()).coerceIn(1, 31)
    val safeMonth = bcdToDec(dateTimeByteArray[1].toUnsignedInt()).coerceIn(1, 12)
    val safeHour = bcdToDec(dateTimeByteArray[3].toUnsignedInt()).coerceIn(0, 23)
    val safeMinute = bcdToDec(dateTimeByteArray[4].toUnsignedInt()).coerceIn(0, 59)
    val safeSecond = bcdToDec(dateTimeByteArray[5].toUnsignedInt()).coerceIn(0, 59)

    return runCatching {
        val date = LocalDate(year = fullYear, month = safeMonth, day = safeDay)
        val time = LocalTime(hour = safeHour, minute = safeMinute, second = safeSecond)
        LocalDateTime(date, time)
    }.getOrNull()
}

fun setDateTimes(): DeviceRequest.SetDateTime {
    val now: Instant = Clock.System.now()
    val localDateTime = now.toLocalDateTime(TimeZone.currentSystemDefault())
    return DeviceRequest.SetDateTime(
        day = decToBcd(localDateTime.day),
        month = decToBcd(localDateTime.month.number),
        year = decToBcd(localDateTime.year % 100),
        hour = decToBcd(localDateTime.hour),
        min = decToBcd(localDateTime.minute),
        sec = decToBcd(localDateTime.second)
    )
}

private fun bcdToDec(bcd: Int): Int {
    return ((bcd shr 4) * 10) + (bcd and 0x0F)
}

private fun decToBcd(dec: Int): Byte {
    return (((dec / 10) shl 4) or (dec % 10)).toByte()
}
