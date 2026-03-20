package com.gorman.bluetooth

import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

object IosBluetoothStreamHandler : KoinComponent {
    private val viewModel: BluetoothDeviceViewModel by inject()
    private var job: Job? = null

    fun startListening(onData: (String) -> Unit, onError: (String) -> Unit) {
        job?.cancel()
        job = CoroutineScope(Dispatchers.Main).launch {
            runCatching {
                viewModel.deviceState.collect { state ->
                    val stateJsonData = Json.encodeToString(state)
                    onData(stateJsonData)
                }
            }
        }
    }

    fun stopListening() {
        job?.cancel()
        job = null
    }

    fun onUiEvent(eventJson: String?) {
        val event = eventJson?.let { Json.decodeFromString<BluetoothUiEvent>(it) }
        viewModel.onUiEvent(event)
    }
}
