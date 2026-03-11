package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.PeripheralDeviceState
import com.juul.kable.Advertisement

fun Advertisement.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = "$identifier"
)
