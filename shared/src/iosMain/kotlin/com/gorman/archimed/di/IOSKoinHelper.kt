package com.gorman.archimed.di

import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import org.koin.core.component.KoinComponent
import org.koin.core.component.get

class IOSKoinHelper : KoinComponent {
    val getHomeViewModel: BluetoothDeviceViewModel get() = get()
}
