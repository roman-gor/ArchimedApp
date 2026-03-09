package com.gorman.bluetooth.di

import dev.bluefalcon.ApplicationContext
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.ServiceFilter
import org.koin.core.scope.Scope
import platform.CoreBluetooth.CBUUID

actual fun Scope.provideBlueFalcon(): BlueFalcon =
    BlueFalcon(
        log = null,
        context = ApplicationContext()
    )

actual fun createUartServiceFilter(uuid: String): ServiceFilter {
    val cbUuid = CBUUID.UUIDWithString(uuid)
    return ServiceFilter(listOf(cbUuid))
}
