package com.gorman.bluetooth.di

import dev.bluefalcon.BlueFalcon
import org.koin.core.scope.Scope
import org.koin.dsl.module

val bluetoothModule = module {
    single<BlueFalcon> {
        provideBlueFalcon()
    }
}

expect fun Scope.provideBlueFalcon(): BlueFalcon
