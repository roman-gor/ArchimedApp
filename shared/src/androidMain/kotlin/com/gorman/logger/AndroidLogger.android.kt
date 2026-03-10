package com.gorman.logger

import android.util.Log

class AndroidLogger : Logger {
    override fun d(tag: String, message: String, cause: Throwable?) {
        Log.d(tag, message, cause)
    }

    override fun e(tag: String, message: String, cause: Throwable?) {
        Log.e(tag, message, cause)
    }
}

actual fun provideAppLogger(): Logger = AndroidLogger()
