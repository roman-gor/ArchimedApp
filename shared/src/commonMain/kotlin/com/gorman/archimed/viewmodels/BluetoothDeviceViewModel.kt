package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.gorman.bluetooth.constants.serviceFilters
import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.states.BluetoothDeviceState
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import com.gorman.bluetooth.data.IBluetoothManager
import com.gorman.bluetooth.states.DeviceEvent
import com.gorman.bluetooth.states.PeripheralDeviceState
import com.gorman.logger.Logger
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class BluetoothDeviceViewModel(
    private val bluetoothManager: IBluetoothManager,
    private val logger: Logger,
    delegate: BleDelegate
): ViewModel() {

    private val _selectedDeviceId = MutableStateFlow<String?>(null)

    @OptIn(ExperimentalCoroutinesApi::class)
    private val devicesFlow = bluetoothManager.peripherals
        .flatMapLatest { peripherals ->
            if (peripherals.isEmpty()) {
                flowOf(emptyList())
            } else {
                val deviceFlows = peripherals.map { peripheral ->
                    bluetoothManager.connectionState(peripheral).map { status ->
                        EnhancedBluetoothPeripheral(
                            connected = status,
                            peripheral = peripheral,
                        )
                    }
                }
                combine(deviceFlows) { it.toList() }
            }
        }
        .map { enhancedList ->
            HashMap(enhancedList.associateBy { it.peripheral.uuid ?: "" })
        }

    val deviceState: StateFlow<BluetoothDeviceState> = combine(
        devicesFlow,
        _selectedDeviceId
    ) { devicesMap, selectedId ->
        val state = BluetoothDeviceState(
            devices = devicesMap,
            isScanning = true,
            selectedDeviceId = selectedId
        )
        logger.d("State", state.toString())
        state
    }.stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(5000L),
        initialValue = BluetoothDeviceState()
    )

    init {
        delegate.setListener { event ->
            when (event) {
                is DeviceEvent.OnDeviceConnected -> {
                    _selectedDeviceId.value = event.macId
                }
                is DeviceEvent.OnDeviceDisconnected -> {
                    if (_selectedDeviceId.value == event.macId) {
                        _selectedDeviceId.value = null
                    }
                }
                else -> {}
            }
        }
        viewModelScope.launch {
            bluetoothManager.scan(serviceFilters)
        }
    }

    fun connect(uuid: String?) {
        viewModelScope.launch {
            bluetoothManager.connect(PeripheralDeviceState(uuid = uuid))
            logger.d("CONNECTING", "METHOD CONNECT WAS CALLED")
        }
    }

    fun disconnect(uuid: String?) {
        viewModelScope.launch {
            bluetoothManager.disconnect(PeripheralDeviceState(uuid = uuid))
            logger.d("DISCONNECTING", "METHOD CONNECT WAS CALLED")
        }
    }
}
