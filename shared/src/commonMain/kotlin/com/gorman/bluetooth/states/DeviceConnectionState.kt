package com.gorman.bluetooth.states

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
sealed class DeviceConnectionState {

    @Serializable
    @SerialName("connecting")
    data object Connecting : DeviceConnectionState()

    @Serializable
    @SerialName("connected")
    data object Connected : DeviceConnectionState()

    @Serializable
    @SerialName("disconnecting")
    data object Disconnecting : DeviceConnectionState()

    @Serializable
    @SerialName("disconnected")
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
