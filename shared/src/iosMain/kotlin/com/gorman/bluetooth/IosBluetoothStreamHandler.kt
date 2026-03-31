package com.gorman.bluetooth

import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject
import kotlin.coroutines.cancellation.CancellationException

object IosBluetoothStreamHandler : KoinComponent {
    private val viewModel: BluetoothDeviceViewModel by inject()
    private var job: Job? = null

    fun startListening(onData: (String) -> Unit, onError: (String) -> Unit) {
        job?.cancel()
        job = CoroutineScope(Dispatchers.Main).launch {
            try {
                viewModel.deviceState.collect { state ->
                    val stateJsonData = Json.encodeToString(state)
                    onData(stateJsonData)
                }
            } catch (e: Exception) {
                if (e !is CancellationException) {
                    onError(e.message ?: "Unknown KMP Error")
                }
            }
        }
    }

    fun stopListening() {
        job?.cancel()
        job = null
    }
}