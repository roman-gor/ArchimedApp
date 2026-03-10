package com.gorman.logger

import org.koin.dsl.module

interface Logger {
    fun d(tag: String, message: String, cause: Throwable? = null)
    fun e(tag: String, message: String, cause: Throwable? = null)
}

expect fun provideAppLogger(): Logger

val loggerModule = module {
    single<Logger> {
        provideAppLogger()
    }
}
