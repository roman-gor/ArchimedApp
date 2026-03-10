package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.archimed.states.BluetoothUiEvent
import com.gorman.bluetooth.constants.serviceFilters
import com.gorman.bluetooth.repository.IBluetoothRepository
import com.gorman.bluetooth.states.BluetoothDeviceState
import com.gorman.bluetooth.states.ConnectionPeripheralState
import com.gorman.bluetooth.states.DeviceEvent
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class BluetoothDeviceViewModel(
    private val bluetoothRepository: IBluetoothRepository,
    private val logger: Logger
) : ViewModel() {

    private val _selectedDeviceId = MutableStateFlow<String?>(null)
    val selectedDeviceId: StateFlow<String?> = _selectedDeviceId.asStateFlow()

    init {
        viewModelScope.launch {
            bluetoothRepository.deviceEvents().collect { event ->
                when (event) {
                    is DeviceEvent.OnDeviceConnected -> {
                        logger.d("FLOW CONNECTED", event.uuid)
                        _selectedDeviceId.value = event.uuid
                    }
                    is DeviceEvent.OnDeviceDisconnected -> {
                        if (_selectedDeviceId.value == event.uuid) {
                            _selectedDeviceId.value = null
                        }
                    }
                    else -> {}
                }
            }
        }
    }

    val deviceState: StateFlow<BluetoothDeviceState> = combine(
        bluetoothRepository.peripherals,
        selectedDeviceId,
    ) { peripherals, selectedId ->
        val deviceFlows = peripherals.associate { peripheral ->

            val connectedState = getConnectionState(selectedId, peripheral)

            peripheral.uuid.toString() to EnhancedBluetoothPeripheral(
                connected = peripheral.uuid == selectedId,
                connectedState = connectedState,
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

    private suspend fun getConnectionState(selectedId: String?, peripheral: PeripheralDeviceState): ConnectionPeripheralState? {
        val connectedState = if (!selectedId.isNullOrEmpty()) {
            bluetoothRepository.connectionState(peripheral)
        } else {
            ConnectionPeripheralState.Disconnected
        }
        return connectedState
    }

    private fun scan() {
        viewModelScope.launch {
            bluetoothRepository.scan(serviceFilters)
        }
    }

    private fun connect(uuid: String?) {
        viewModelScope.launch {
            val currentSelected = _selectedDeviceId.value

            if (currentSelected != null && currentSelected != uuid) {
                logger.d("DISCONNECTING OLD", "Disconnecting $currentSelected before connecting to new")
                bluetoothRepository.disconnect(PeripheralDeviceState(uuid = currentSelected))
            }

            _selectedDeviceId.value = null
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
