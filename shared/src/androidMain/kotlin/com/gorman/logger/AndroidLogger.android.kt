package com.gorman.logger

import android.util.Log

class AndroidLogger : Logger {
    override fun d(tag: String, message: String) {
        Log.d(tag, message)
    }

    override fun e(tag: String, message: String, throwable: Throwable?) {
        Log.e(tag, message, throwable)
    }
}

actual fun provideAppLogger(): Logger = AndroidLogger()
