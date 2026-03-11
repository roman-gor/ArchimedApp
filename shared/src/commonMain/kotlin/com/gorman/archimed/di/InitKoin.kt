package com.gorman.archimed.di

import com.gorman.bluetooth.di.bluetoothModule
import com.gorman.bluetooth.di.bluetoothParsingModule
import com.gorman.logger.loggerModule
import org.koin.core.context.startKoin
import org.koin.dsl.KoinAppDeclaration

fun initKoin(config: KoinAppDeclaration? = null) {
    startKoin {
        config?.invoke(this)
        modules(
            bluetoothModule,
            bluetoothParsingModule,
            viewModelModule,
            loggerModule
        )
    }
}
