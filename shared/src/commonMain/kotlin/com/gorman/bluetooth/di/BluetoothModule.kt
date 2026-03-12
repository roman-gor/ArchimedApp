package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.parsers.DeviceResponseHandlerUseCase
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.strategies.DownloadDataResponseStrategy
import com.gorman.bluetooth.parsers.strategies.DownloadInformationResponseStrategy
import com.gorman.bluetooth.parsers.strategies.OnlineDataResponseStrategy
import com.gorman.bluetooth.parsers.strategies.SensorParametersResponseStrategy
import com.gorman.bluetooth.parsers.strategies.SensorValuesResponseStrategy
import com.gorman.bluetooth.parsers.strategies.StatusResponseStrategy
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

val bluetoothParsingModule = module {
    singleOf(::StatusResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::OnlineDataResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::SensorParametersResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::DownloadDataResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::DownloadInformationResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::SensorValuesResponseStrategy) bind DeviceResponseStrategy::class
    single { DeviceResponseHandlerUseCase(getAll<DeviceResponseStrategy>().toSet(), get()) }
}
