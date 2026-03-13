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

fun getDateTime(dateTimeByteArray: ByteArray): LocalDateTime? {
    if (dateTimeByteArray.size != 6) return null

    val fullYear = if (dateTimeByteArray[2] < 100) {
        2000 + dateTimeByteArray[2].toUnsignedInt()
    } else {
        dateTimeByteArray[2].toUnsignedInt()
    }
    val safeDay = dateTimeByteArray[0].toUnsignedInt().coerceIn(1, 31)
    val safeMonth = dateTimeByteArray[1].toUnsignedInt().coerceIn(1, 12)
    val safeHour = dateTimeByteArray[3].toUnsignedInt().coerceIn(0, 23)
    val safeMinute = dateTimeByteArray[4].toUnsignedInt().coerceIn(0, 59)
    val safeSecond = dateTimeByteArray[5].toUnsignedInt().coerceIn(0, 59)

    return runCatching {
        val date = LocalDate(year = fullYear, month = safeMonth, day = safeDay)
        val time = LocalTime(hour = safeHour, minute = safeMinute, second = safeSecond)
        LocalDateTime(date, time)
    }.getOrNull()
}
