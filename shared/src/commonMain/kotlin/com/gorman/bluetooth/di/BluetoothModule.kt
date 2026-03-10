package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.repository.BluetoothRepository
import com.gorman.bluetooth.repository.IBluetoothRepository
import com.gorman.logger.BluetoothLogger
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.Logger
import dev.bluefalcon.ServiceFilter
import org.koin.core.module.dsl.singleOf
import org.koin.core.scope.Scope
import org.koin.dsl.bind
import org.koin.dsl.module

val bluetoothModule = module {
    single<BleDelegate> {
        BleDelegate()
    }
    singleOf(::BluetoothLogger).bind<Logger>()
    single<BlueFalcon> {
        val delegate = get<BleDelegate>()
        val logger = get<BluetoothLogger>()
        provideBlueFalcon(logger).apply {
            delegates.add(delegate)
        }
    }
    single<BluetoothManager> {
        BluetoothManager(get())
    }
    singleOf(::BluetoothRepository).bind<IBluetoothRepository>()
}

expect fun Scope.provideBlueFalcon(logger: Logger): BlueFalcon

expect fun createUartServiceFilter(uuid: String): ServiceFilter
