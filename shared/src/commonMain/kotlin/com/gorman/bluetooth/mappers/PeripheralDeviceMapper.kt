package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.PeripheralDeviceState
import com.juul.kable.Advertisement
import com.juul.kable.ExperimentalApi
import com.juul.kable.Peripheral

@OptIn(ExperimentalApi::class)
fun Peripheral.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = identifier.toString()
)

fun Advertisement.toDomain() = PeripheralDeviceState(
    name = name,
    uuid = identifier.toString()
)
