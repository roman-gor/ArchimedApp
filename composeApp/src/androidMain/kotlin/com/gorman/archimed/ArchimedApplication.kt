package com.gorman.archimed

import android.app.Application
import android.util.Log
import com.gorman.archimed.di.initKoin
import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import com.gorman.bluetooth.constants.MethodChannelCommands
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import org.koin.android.ext.android.inject
import org.koin.android.ext.koin.androidContext
import org.koin.android.ext.koin.androidLogger

class ArchimedApplication : Application() {
    lateinit var flutterEngine: FlutterEngine
    private val bluetoothViewModel: BluetoothDeviceViewModel by inject()
    private var job: Job? = null

    override fun onCreate() {
        super.onCreate()
        setupKoin()
        setupFlutterEngine(bluetoothViewModel)
    }

    private fun setupKoin() {
        initKoin {
            androidContext(this@ArchimedApplication)
            androidLogger()
        }
        Log.d("App", "Koin initialized successfully")
    }

    private fun setupFlutterEngine(viewModel: BluetoothDeviceViewModel) {
        flutterEngine = FlutterEngine(this)

        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache
            .getInstance()
            .put("flutter_ui_main_engine", flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, "com.gorman.archimed/events")
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    job = CoroutineScope(Dispatchers.Main).launch {
                        Log.d("State Event Channel", "Start Event Channel Listen")
                        runCatching {
                            viewModel.deviceState.collect { state ->
                                val stateJsonData = Json.encodeToString(state)
                                Log.d("State Event Channel", stateJsonData)
                                events?.success(stateJsonData)
                            }
                        }.onFailure { e ->
                            Log.e("State Event Channel", "Failure: ${e.message}")
                        }
                    }
                }

                override fun onCancel(arguments: Any?) {
                    job?.cancel()
                }
            })

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.gorman.archimed/methods")
            .setMethodCallHandler { call, result ->
                observeMethodChannelCommands(call, viewModel, result)
            }
    }

    private fun observeMethodChannelCommands(
        call: MethodCall,
        viewModel: BluetoothDeviceViewModel,
        result: MethodChannel.Result
    ) {
        when (call.method) {
            MethodChannelCommands.ON_UI_EVENT.value -> {
                runCatching {
                    val commandJson = call.argument<String>("command")
                    val bluetoothUiEvent = commandJson?.let { Json.decodeFromString<BluetoothUiEvent>(commandJson) }
                    Log.d("Bluetooth Ui Event", bluetoothUiEvent.toString())
                    viewModel.onUiEvent(bluetoothUiEvent)
                }
                    .onSuccess { result.success(null) }
                    .onFailure { e -> result.error("Error start scan", "${e.message}", null) }
            }
        }
    }
}
