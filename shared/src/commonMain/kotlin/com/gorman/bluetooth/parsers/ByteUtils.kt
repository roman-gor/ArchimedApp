package com.gorman.bluetooth.parsers

fun Byte.toUnsignedInt(): Int = this.toInt() and 0xFF

// TODO(Let it be)
fun ByteArray.read2BytesAsShort(startIndex: Int): Short {
    val high = this[startIndex].toUnsignedInt()
    val low = this[startIndex + 1].toUnsignedInt()
    val rawInt = (high shl 8) or low
    return rawInt.toShort()
}
