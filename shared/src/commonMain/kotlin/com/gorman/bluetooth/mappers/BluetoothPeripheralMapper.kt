package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.PeripheralDeviceState
import dev.bluefalcon.BluetoothPeripheral

fun BluetoothPeripheral.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = uuid
)
