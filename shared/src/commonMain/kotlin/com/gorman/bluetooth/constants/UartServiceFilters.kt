package com.gorman.bluetooth.constants

import kotlin.uuid.ExperimentalUuidApi
import kotlin.uuid.Uuid

@OptIn(ExperimentalUuidApi::class)
enum class UartServiceFilters(val value: Uuid) {
    UART_SERVICE_UUID(Uuid.parse("6e400001-b5a3-f393-e0a9-e50e24dcca9e")),
    UART_CHARACTERISTIC_RX(Uuid.parse("6e400002-b5a3-f393-e0a9-e50e24dcca9e")),
    UART_CHARACTERISTIC_TX(Uuid.parse("6e400003-b5a3-f393-e0a9-e50e24dcca9e"))
}

@OptIn(ExperimentalUuidApi::class)
val serviceFilters = listOf(UartServiceFilters.UART_SERVICE_UUID.value)
