package com.gorman.bluetooth.di

import com.gorman.bluetooth.data.BluetoothManager
import com.gorman.bluetooth.parsers.DeviceResponseHandlerUseCase
import com.gorman.bluetooth.parsers.DeviceResponseStrategy
import com.gorman.bluetooth.parsers.strategies.ExperimentDataResponseStrategy
import com.gorman.bluetooth.parsers.strategies.ExperimentOnlineDataResponseStrategy
import com.gorman.bluetooth.parsers.strategies.ExternalSensorDataResponseStrategy
import com.gorman.bluetooth.parsers.strategies.GetExperimentsListResponseStrategy
import com.gorman.bluetooth.parsers.strategies.SensorValuesResponseStrategy
import com.gorman.bluetooth.parsers.strategies.SensorsIdParametersResponseStrategy
import com.gorman.bluetooth.parsers.strategies.StatusDeviceResponseStrategy
import com.gorman.bluetooth.repository.BluetoothRepository
import com.gorman.bluetooth.repository.IBluetoothRepository
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.bind
import org.koin.dsl.module

val bluetoothModule = module {
    single<BluetoothManager> {
        BluetoothManager()
    }
    singleOf(::BluetoothRepository) bind IBluetoothRepository::class
    singleOf(::StatusDeviceResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::ExperimentOnlineDataResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::SensorsIdParametersResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::ExperimentDataResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::GetExperimentsListResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::SensorValuesResponseStrategy) bind DeviceResponseStrategy::class
    singleOf(::ExternalSensorDataResponseStrategy) bind DeviceResponseStrategy::class
    single { DeviceResponseHandlerUseCase(getAll<DeviceResponseStrategy>().toSet(), get()) }
}
