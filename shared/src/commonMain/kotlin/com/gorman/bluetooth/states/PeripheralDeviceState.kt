package com.gorman.bluetooth.states

import kotlinx.serialization.Serializable

@Serializable
data class PeripheralDeviceState(
    val name: String? = null,
    val uuid: String
)
