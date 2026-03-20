package com.gorman.bluetooth.mappers

import com.gorman.bluetooth.states.DeviceConnectionState
import com.gorman.bluetooth.states.DisconnectReason
import com.juul.kable.State

fun State.toDomain(): DeviceConnectionState = when (this) {
    is State.Connecting -> DeviceConnectionState.Connecting

    is State.Connected -> DeviceConnectionState.Connected

    is State.Disconnecting -> DeviceConnectionState.Disconnecting

    is State.Disconnected -> DeviceConnectionState.Disconnected(this.status?.toDomain())
}

private fun State.Disconnected.Status.toDomain(): DisconnectReason = when (this) {
    State.Disconnected.Status.PeripheralDisconnected -> DisconnectReason.PeripheralDisconnected
    State.Disconnected.Status.Failed -> DisconnectReason.Failed
    State.Disconnected.Status.Timeout -> DisconnectReason.Timeout
    State.Disconnected.Status.UnknownDevice -> DisconnectReason.UnknownDevice
    State.Disconnected.Status.Cancelled -> DisconnectReason.Cancelled
    is State.Disconnected.Status.Unknown -> DisconnectReason.Unknown(this.status)
    else -> DisconnectReason.Unknown(-1)
}
