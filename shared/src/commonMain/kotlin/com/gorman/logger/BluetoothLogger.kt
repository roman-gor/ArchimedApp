package com.gorman.logger

import dev.bluefalcon.Logger

class BluetoothLogger(
    private val logger: com.gorman.logger.Logger
) : Logger {
    override fun error(message: String, cause: Throwable?) {
        logger.e("Bluetooth Log", message, cause)
    }

    override fun warn(message: String, cause: Throwable?) {
        logger.d("Bluetooth Log", message, cause)
    }

    override fun info(message: String, cause: Throwable?) {
        logger.d("Bluetooth Log", message, cause)
    }

    override fun debug(message: String, cause: Throwable?) {
        logger.d("Bluetooth Log", message, cause)
    }
}
