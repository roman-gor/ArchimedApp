package com.gorman.bluetooth

import dev.bluefalcon.BlueFalcon

class BluetoothManager (
    private val blueFalcon: BlueFalcon
) {
    val peripherals = blueFalcon.peripherals

    fun scan() { blueFalcon.scan() }
}
