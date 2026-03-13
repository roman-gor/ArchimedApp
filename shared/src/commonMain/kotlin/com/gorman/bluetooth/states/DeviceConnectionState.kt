package com.gorman.bluetooth.states

// TODO(Think `Do you need this class? Does it use anywhere?`)
sealed class DeviceConnectionState {
    sealed class Connecting : DeviceConnectionState() {
        data object Bluetooth : Connecting()
        data object Services : Connecting()
        data object Observes : Connecting()
    }

    data object Connected : DeviceConnectionState()

    data object Disconnecting : DeviceConnectionState()

    data class Disconnected(val reason: DisconnectReason? = null) : DeviceConnectionState()
}

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
