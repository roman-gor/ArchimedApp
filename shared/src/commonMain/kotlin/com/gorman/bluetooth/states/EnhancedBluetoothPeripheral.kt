package com.gorman.bluetooth.states

import kotlinx.serialization.Serializable

@Serializable
data class EnhancedBluetoothPeripheral(
    val connected: Boolean,
    val connectedState: DeviceConnectionState,
    val peripheral: PeripheralDeviceState
)
