package com.gorman.logger

interface Logger {
    fun d(tag: String, message: String)
    fun e(tag: String, message: String, throwable: Throwable?)
}

expect fun provideAppLogger(): Logger
