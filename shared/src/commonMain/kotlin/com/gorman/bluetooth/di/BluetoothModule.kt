package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BleDelegate
import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.data.IBluetoothManager
import com.gorman.bluetooth.repository.BluetoothRepository
import com.gorman.bluetooth.repository.IBluetoothRepository
import dev.bluefalcon.BlueFalcon
import dev.bluefalcon.ServiceFilter
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.SupervisorJob
import org.koin.core.module.dsl.singleOf
import org.koin.core.scope.Scope
import org.koin.dsl.bind
import org.koin.dsl.module

val bluetoothModule = module {
    single<BleDelegate> {
        BleDelegate()
    }
    single<BlueFalcon> {
        val delegate = get<BleDelegate>()
        provideBlueFalcon().apply {
            delegates.add(delegate)
        }
    }
    singleOf(::BluetoothManager).bind<IBluetoothManager>()
    singleOf(::BluetoothRepository).bind<IBluetoothRepository>()
}

expect fun Scope.provideBlueFalcon(): BlueFalcon

expect fun createUartServiceFilter(uuid: String): ServiceFilter
