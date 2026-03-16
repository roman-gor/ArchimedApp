package com.gorman.bluetooth.data

import com.gorman.bluetooth.constants.serviceFilters
import com.juul.kable.Advertisement
import com.juul.kable.Characteristic
import com.juul.kable.ObsoleteKableApi
import com.juul.kable.Peripheral
import com.juul.kable.Scanner
import com.juul.kable.State
import com.juul.kable.WriteType
import com.juul.kable.logs.Hex
import com.juul.kable.logs.Logging
import com.juul.kable.logs.SystemLogEngine
import kotlinx.coroutines.flow.Flow
import kotlin.uuid.ExperimentalUuidApi

internal class BluetoothManager {

    @OptIn(ExperimentalUuidApi::class, ObsoleteKableApi::class)
    fun scan(): Flow<Advertisement> =
        Scanner {
            filters {
                match {
                    services = serviceFilters
                }
            }
            logging {
                level = Logging.Level.Data
                format = Logging.Format.Multiline
                engine = SystemLogEngine
                data = Hex
            }
        }.advertisements

    @OptIn(ObsoleteKableApi::class)
    fun createPeripheral(advertisement: Advertisement): Peripheral {
        return Peripheral(advertisement) {
            logging {
                level = Logging.Level.Data
                format = Logging.Format.Multiline
                engine = SystemLogEngine
                data = Hex
            }
        }
    }

    suspend fun connect(peripheral: Peripheral) {
        peripheral.connect()
    }

    suspend fun disconnect(peripheral: Peripheral) {
        peripheral.disconnect()
    }

    fun connectionState(peripheral: Peripheral): Flow<State> = peripheral.state

    fun observeCharacteristic(
        peripheral: Peripheral,
        characteristic: Characteristic
    ): Flow<ByteArray> =
        peripheral.observe(characteristic)

    suspend fun writeCharacteristic(
        peripheral: Peripheral,
        characteristic: Characteristic,
        value: ByteArray,
        withResponse: Boolean = true
    ) {
        val writeType = if (withResponse) WriteType.WithResponse else WriteType.WithoutResponse
        peripheral.write(
            characteristic = characteristic,
            data = value,
            writeType = writeType
        )
    }

    suspend fun readCharacteristic(
        peripheral: Peripheral,
        characteristic: Characteristic
    ): ByteArray =
        peripheral.read(characteristic)
}
