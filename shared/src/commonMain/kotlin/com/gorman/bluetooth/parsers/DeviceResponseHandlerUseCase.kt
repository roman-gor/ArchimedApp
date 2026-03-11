package com.gorman.bluetooth.parsers

import com.gorman.bluetooth.models.DeviceResponse

class DeviceResponseHandlerUseCase(
    private val strategies: Set<DeviceResponseStrategy>
) {
    operator fun invoke(incomingBytes: ByteArray): DeviceResponse {
        val strategy = strategies.firstOrNull { it.canParse(incomingBytes) }
        return strategy?.parse(incomingBytes)
            ?: DeviceResponse.Unknown(incomingBytes[2].toInt(), incomingBytes)
    }
}
