package com.gorman.bluetooth.parsers

fun Byte.toUnsignedInt(): Int = this.toInt() and 0xFF

fun ByteArray.read2BytesAsInt(startIndex: Int): Int {
    val high = this[startIndex].toUnsignedInt()
    val low = this[startIndex + 1].toUnsignedInt()
    val rawInt = (high shl 8) or low
    return rawInt.toShort().toInt()
}
