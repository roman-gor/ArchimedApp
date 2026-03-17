package com.gorman.archimed

import android.app.Application
import android.util.Log
import com.gorman.archimed.di.initKoin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger

class ArchimedApplication : Application() {
    lateinit var flutterEngine : FlutterEngine

    override fun onCreate() {
        super.onCreate()
        setupKoin()
        setupFlutterEngine()
    }

    private fun setupKoin() {
        initKoin {
            androidContext(this@ArchimedApplication)
            androidLogger()
        }
        Log.d("App", "Koin initialized successfully")
    }

    private fun setupFlutterEngine() {
        flutterEngine = FlutterEngine(this)

        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("flutter_ui_main_engine", flutterEngine)
    }
}
