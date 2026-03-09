package com.gorman.archimed.di

import com.gorman.bluetooth.di.bluetoothModule
import org.koin.core.context.startKoin
import org.koin.dsl.KoinAppDeclaration

fun initKoin(config: KoinAppDeclaration? = null) {
    startKoin {
        config?.invoke(this)
        modules(
            bluetoothModule
        )
    }
}
