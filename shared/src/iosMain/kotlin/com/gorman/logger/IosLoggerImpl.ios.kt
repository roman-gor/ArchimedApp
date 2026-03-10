package com.gorman.logger

import platform.Foundation.NSLog

class IosLoggerImpl : Logger {
    override fun d(tag: String, message: String, cause: Throwable?) {
        val errorInfo = cause?.message ?: "No error message"
        NSLog("[%s] DEBUG: %s", tag, message, errorInfo)
    }
    override fun e(tag: String, message: String, cause: Throwable?) {
        val errorInfo = cause?.message ?: "No error message"
        NSLog("[%s] ERROR: %s. Exception: %s", tag, message, errorInfo)
    }
}

actual fun provideAppLogger(): Logger = IosLoggerImpl()
