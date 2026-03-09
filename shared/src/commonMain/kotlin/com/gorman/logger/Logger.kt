package com.gorman.logger

import org.koin.dsl.module

interface Logger {
    fun d(tag: String, message: String)
    fun e(tag: String, message: String, throwable: Throwable?)
}

expect fun provideAppLogger(): Logger

val loggerModule = module {
    single<Logger> {
        provideAppLogger()
    }
}
