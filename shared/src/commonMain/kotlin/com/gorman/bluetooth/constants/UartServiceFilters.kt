package com.gorman.bluetooth.constants

import com.gorman.bluetooth.di.createUartServiceFilter

enum class UartServiceFilters(val value: String) {
    UART_SERVICE_UUID("6e400001-b5a3-f393-e0a9-e50e24dcca9e"),
    UART_CHARACTERISTIC_RX("6e400002-b5a3-f393-e0a9-e50e24dcca9e"),
    UART_CHARACTERISTIC_TX("6e400003-b5a3-f393-e0a9-e50e24dcca9e")
}

val serviceFilters = UartServiceFilters.entries.map { createUartServiceFilter(it.value) }
