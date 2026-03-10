package com.gorman.bluetooth.di

import android.os.ParcelUuid
import dev.bluefalcon.ApplicationContext
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.Logger
import dev.bluefalcon.ServiceFilter
import org.koin.android.ext.koin.androidContext
import org.koin.core.scope.Scope

actual fun Scope.provideBlueFalcon(logger: Logger): BlueFalcon =
    BlueFalcon(
        log = logger,
        context = androidContext() as ApplicationContext
    )

actual fun createUartServiceFilter(uuid: String): ServiceFilter {
    val parcelUuid = ParcelUuid.fromString(uuid)
    return ServiceFilter(listOf(parcelUuid))
}
