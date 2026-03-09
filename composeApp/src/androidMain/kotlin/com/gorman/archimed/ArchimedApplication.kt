package com.gorman.archimed

import android.app.Application
import android.util.Log
import com.gorman.archimed.di.initKoin
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger

class ArchimedApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        initKoin {
            androidContext(this@ArchimedApplication)
            androidLogger()
        }
        Log.d("App", "Koin initialized successfully")
    }
}
