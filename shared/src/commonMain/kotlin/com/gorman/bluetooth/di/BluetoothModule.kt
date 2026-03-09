package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.data.IBluetoothManager
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.ServiceFilter
import org.koin.core.module.dsl.singleOf
import org.koin.core.scope.Scope
import org.koin.dsl.bind
import org.koin.dsl.module

val bluetoothModule = module {
    single<BlueFalcon> {
        provideBlueFalcon()
    }
    single<BleDelegate> {
        BleDelegate()
    }
    singleOf(::BluetoothManager).bind<IBluetoothManager>()
}

expect fun Scope.provideBlueFalcon(): BlueFalcon

expect fun createUartServiceFilter(uuid: String): ServiceFilter
