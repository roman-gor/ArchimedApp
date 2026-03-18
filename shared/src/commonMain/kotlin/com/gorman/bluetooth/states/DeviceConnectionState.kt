package com.gorman.bluetooth.states

import kotlinx.serialization.Serializable

@Serializable
sealed class DeviceConnectionState {
    @Serializable
    data object Connecting : DeviceConnectionState()
    @Serializable
    data object Connected : DeviceConnectionState()
    @Serializable
    data object Disconnecting : DeviceConnectionState()
    @Serializable
    data class Disconnected(val reason: DisconnectReason? = null) : DeviceConnectionState()
}

@Serializable
sealed class DisconnectReason {
    data object PeripheralDisconnected : DisconnectReason()
    data object CentralDisconnected : DisconnectReason()
    data object Failed : DisconnectReason()
    data object L2CapFailure : DisconnectReason()
    data object Timeout : DisconnectReason()
    data object LinkManagerProtocolTimeout : DisconnectReason()
    data object UnknownDevice : DisconnectReason()
    data object Cancelled : DisconnectReason()
    data object ConnectionLimitReached : DisconnectReason()
    data object EncryptionTimedOut : DisconnectReason()
    data class Unknown(val code: Int) : DisconnectReason()
}
