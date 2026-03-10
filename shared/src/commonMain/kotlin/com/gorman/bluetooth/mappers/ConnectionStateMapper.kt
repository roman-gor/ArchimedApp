package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.DisconnectReason
import com.juul.kable.State

fun State.toDomain(): DeviceConnectionState = when (this) {
    is State.Connecting.Bluetooth -> DeviceConnectionState.Connecting.Bluetooth
    is State.Connecting.Services -> DeviceConnectionState.Connecting.Services
    is State.Connecting.Observes -> DeviceConnectionState.Connecting.Observes

    is State.Connected -> DeviceConnectionState.Connected

    is State.Disconnecting -> DeviceConnectionState.Disconnecting

    is State.Disconnected -> DeviceConnectionState.Disconnected(this.status?.toDomain())
}

private fun State.Disconnected.Status.toDomain(): DisconnectReason = when (this) {
    State.Disconnected.Status.PeripheralDisconnected -> DisconnectReason.PeripheralDisconnected
    State.Disconnected.Status.CentralDisconnected -> DisconnectReason.CentralDisconnected
    State.Disconnected.Status.Failed -> DisconnectReason.Failed
    State.Disconnected.Status.L2CapFailure -> DisconnectReason.L2CapFailure
    State.Disconnected.Status.Timeout -> DisconnectReason.Timeout
    State.Disconnected.Status.LinkManagerProtocolTimeout -> DisconnectReason.LinkManagerProtocolTimeout
    State.Disconnected.Status.UnknownDevice -> DisconnectReason.UnknownDevice
    State.Disconnected.Status.Cancelled -> DisconnectReason.Cancelled
    State.Disconnected.Status.ConnectionLimitReached -> DisconnectReason.ConnectionLimitReached
    State.Disconnected.Status.EncryptionTimedOut -> DisconnectReason.EncryptionTimedOut
    is State.Disconnected.Status.Unknown -> DisconnectReason.Unknown(this.status)
}
