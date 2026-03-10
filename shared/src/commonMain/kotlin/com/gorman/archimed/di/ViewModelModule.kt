package com.gorman.archimed.di

import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import org.koin.core.module.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel {
        BluetoothDeviceViewModel(get(), get())
    }
}
