package com.gorman.bluetooth.states

data class EnhancedBluetoothPeripheral(
    val connected: Boolean,
    val connectedState: DeviceConnectionState,
    val peripheral: PeripheralDeviceState
)
