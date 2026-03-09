package com.gorman.bluetooth.di

import dev.bluefalcon.ApplicationContext
import dev.bluefalcon.BlueFalcon
import org.koin.core.scope.Scope

actual fun Scope.provideBlueFalcon(): BlueFalcon =
    BlueFalcon(
        log = null,
        context = ApplicationContext()
    )
