package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.BluetoothUiEvent
import com.gorman.bluetooth.constants.serviceFilters
import com.gorman.bluetooth.repository.IBluetoothRepository
import com.gorman.bluetooth.states.BluetoothDeviceState
import com.gorman.bluetooth.states.DeviceEvent
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.flow.runningFold
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class BluetoothDeviceViewModel(
    private val bluetoothRepository: IBluetoothRepository,
    private val logger: Logger
) : ViewModel() {

    private val selectedDeviceId: StateFlow<String?> = bluetoothRepository.deviceEvents()
        .runningFold<DeviceEvent, String?>(null) { currentId, event ->
            when (event) {
                is DeviceEvent.OnDeviceConnected -> {
                    logger.d("FLOW CONNECTED", event.macId)
                    event.macId
                }
                is DeviceEvent.OnDeviceDisconnected -> {
                    if (currentId == event.macId) null else currentId
                }
                else -> currentId
            }
        }
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000L),
            initialValue = null
        )

    val deviceState: StateFlow<BluetoothDeviceState> = combine(
        bluetoothRepository.peripherals,
        selectedDeviceId
    ) { peripherals, selectedId ->

        val deviceFlows = peripherals.associate { peripheral ->
            peripheral.uuid.toString() to EnhancedBluetoothPeripheral(
                connected = peripheral.uuid == selectedId,
                peripheral = peripheral,
            )
        }

        val state = BluetoothDeviceState(
            devices = deviceFlows,
            isScanning = true,
            selectedDeviceId = selectedId
        )
        logger.d("State", state.toString())
        state
    }.onStart {
        scan()
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000L),
        initialValue = BluetoothDeviceState()
    )

    fun onUiEvent(uiEvent: BluetoothUiEvent) {
        when (uiEvent) {
            is BluetoothUiEvent.OnConnect -> connect(uiEvent.uuid)
            is BluetoothUiEvent.OnDisconnect -> disconnect(uiEvent.uuid)
            BluetoothUiEvent.OnScan -> scan()
        }
    }

    private fun scan() {
        viewModelScope.launch {
            bluetoothRepository.scan(serviceFilters)
        }
    }

    private fun connect(uuid: String?) {
        viewModelScope.launch {
            bluetoothRepository.connect(PeripheralDeviceState(uuid = uuid))
            logger.d("CONNECTING", "METHOD CONNECT WAS CALLED")
        }
    }

    private fun disconnect(uuid: String?) {
        viewModelScope.launch {
            bluetoothRepository.disconnect(PeripheralDeviceState(uuid = uuid))
            logger.d("DISCONNECTING", "METHOD CONNECT WAS CALLED")
        }
    }
}
