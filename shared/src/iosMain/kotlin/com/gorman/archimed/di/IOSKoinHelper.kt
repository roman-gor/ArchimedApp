package com.gorman.archimed.di

import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import org.koin.core.component.KoinComponent

class IOSKoinHelper : KoinComponent {
    val getHomeViewModel: BluetoothDeviceViewModel get() = get()
}
