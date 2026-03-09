package com.gorman.archimed.viewmodels

import androidx.lifecycle.ViewModel
import com.gorman.archimed.BluetoothDeviceState
import com.gorman.archimed.EnhancedBluetoothPeripheral
import com.gorman.archimed.toDomain
import com.gorman.bluetooth.BluetoothManager
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class BluetoothDeviceViewModel(
    private val bluetoothManager: BluetoothManager
): ViewModel() {

    private val _deviceState = MutableStateFlow(BluetoothDeviceState())
    val deviceState: StateFlow<BluetoothDeviceState> get() = _deviceState

    init {
        CoroutineScope(Dispatchers.IO).launch {
            bluetoothManager.scan()
            bluetoothManager.peripherals.collect { peripherals ->
                val uniqueKeys = _deviceState.value.devices.keys.toList()
                val filteredPeripheral = peripherals.filter { !uniqueKeys.contains(it.uuid) }
                filteredPeripheral.forEach { peripheral ->
                    _deviceState.update {
                        val updateDevices = it.devices.toMutableMap()
                        updateDevices[peripheral.uuid] =
                            EnhancedBluetoothPeripheral(false, peripheral.toDomain())
                        it.copy(
                            devices = HashMap(updateDevices)
                        )
                    }
                }
            }
        }
    }
}
