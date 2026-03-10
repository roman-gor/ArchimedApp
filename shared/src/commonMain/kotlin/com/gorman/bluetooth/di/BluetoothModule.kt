package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.repository.BluetoothRepository
import com.gorman.bluetooth.repository.IBluetoothRepository
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.bind
import org.koin.dsl.module

val bluetoothModule = module {
    single<BluetoothManager> {
        BluetoothManager()
    }
    singleOf(::BluetoothRepository).bind<IBluetoothRepository>()
}
