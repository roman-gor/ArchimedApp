package com.gorman.bluetooth.parsers

import kotlinx.datetime.LocalDate
import kotlinx.datetime.LocalDateTime
import kotlinx.datetime.LocalTime

fun Byte.toUnsignedInt(): Int = this.toInt() and 0xFF

fun ByteArray.read2BytesAsShort(startIndex: Int): Short {
    val high = this[startIndex].toUnsignedInt()
    val low = this[startIndex + 1].toUnsignedInt()
    val rawInt = (high shl 8) or low
    return rawInt.toShort()
}

fun getDateTime(
    day: Byte,
    month: Byte,
    year: Byte,
    hour: Byte,
    minute: Byte,
    second: Byte
): LocalDateTime? {
    val fullYear = if (year < 100) (2000 + year.toUnsignedInt()) else year.toUnsignedInt()

    val safeMonth = month.toUnsignedInt().coerceIn(1, 12)
    val safeDay = day.toUnsignedInt().coerceIn(1, 31)
    val safeHour = hour.toUnsignedInt().coerceIn(0, 23)
    val safeMinute = minute.toUnsignedInt().coerceIn(0, 59)
    val safeSecond = second.toUnsignedInt().coerceIn(0, 59)

    return runCatching {
        val date = LocalDate(year = fullYear, month = safeMonth, day = safeDay)
        val time = LocalTime(hour = safeHour, minute = safeMinute, second = safeSecond)
        LocalDateTime(date, time)
    }.onFailure {
        LocalDateTime(LocalDate(2000, 1, 1), LocalTime(0, 0, 0))
    }.getOrNull()
}
