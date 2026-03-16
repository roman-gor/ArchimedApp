package com.gorman.bluetooth.parsers

import com.gorman.bluetooth.constants.ResponsesTypes
import com.gorman.bluetooth.models.DeviceResponse
import com.gorman.logger.Logger

class DeviceResponseHandlerUseCase(
    private val strategies: Set<DeviceResponseStrategy>,
    private val logger: Logger
) {
    private var downloadBuffer = byteArrayOf()
    private var isCollectingDownload = false
    private val downloadDataByte = ResponsesTypes.GET_EXPERIMENT_DATA.type
    private val downloadDataSize = ResponsesTypes.GET_EXPERIMENT_DATA.responseLength

    operator fun invoke(incomingBytes: ByteArray): List<DeviceResponse> {
        val parsedResponses = mutableListOf<DeviceResponse>()

        if (isCollectingDownload) {
            downloadBuffer += incomingBytes
            logger.d("UART_RX", "Gluing 0x54... current size: ${downloadBuffer.size} / $downloadDataSize")

            if (downloadBuffer.size >= downloadDataSize) {
                val fullPacket = downloadBuffer.copyOfRange(0, downloadDataSize)
                val remainder = downloadBuffer.copyOfRange(downloadDataSize, downloadBuffer.size)

                strategies.find { it.responseType == downloadDataByte }?.parse(fullPacket)?.let {
                    parsedResponses.add(it)
                }

                isCollectingDownload = false
                downloadBuffer = byteArrayOf()

                if (remainder.isNotEmpty()) {
                    parsedResponses.addAll(invoke(remainder))
                }
            }
            return parsedResponses
        }

        val strategy = strategies.find { it.canParse(incomingBytes) }

        if (strategy != null) {
            if (strategy.responseType == downloadDataByte) {
                isCollectingDownload = true
                downloadBuffer = incomingBytes
                logger.d("UART_RX", "Started gluing 0x54 packet")

                if (downloadBuffer.size >= downloadDataSize) {
                    parsedResponses.addAll(invoke(byteArrayOf()))
                }
            } else {
                strategy.parse(incomingBytes)?.let { parsedResponses.add(it) }
            }
        } else {
            logger.d("UART_RX", "Garbage bytes or unhandled fragment received: size ${incomingBytes.size}")
        }

        return parsedResponses
    }
}
