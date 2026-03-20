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
    @Serializable
    @SerialName("peripheral_disconnected")
    data object PeripheralDisconnected : DisconnectReason()

    @Serializable
    @SerialName("failed")
    data object Failed : DisconnectReason()

    @Serializable
    @SerialName("timeout")
    data object Timeout : DisconnectReason()

    @Serializable
    @SerialName("unknown_device")
    data object UnknownDevice : DisconnectReason()

    @Serializable
    @SerialName("cancelled")
    data object Cancelled : DisconnectReason()

    @Serializable
    @SerialName("unknown")
    data class Unknown(@SerialName("code") val code: Int) : DisconnectReason()
}
