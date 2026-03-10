package com.gorman.archimed

import android.Manifest
import android.os.Build
import android.util.Log
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.google.accompanist.permissions.ExperimentalPermissionsApi
import com.google.accompanist.permissions.rememberMultiplePermissionsState
import com.gorman.archimed.states.BluetoothUiEvent
import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import com.gorman.bluetooth.constants.DeviceCommands
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import org.koin.compose.viewmodel.koinViewModel

@OptIn(ExperimentalPermissionsApi::class)
@Composable
fun App() {
    val permissionsState = rememberMultiplePermissionsState(
        permissions =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            listOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.BLUETOOTH_SCAN,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
            )
        } else {
            listOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
            )
        }
    )

    if (permissionsState.allPermissionsGranted) {
        val viewModel: BluetoothDeviceViewModel = koinViewModel()
        val state by viewModel.deviceState.collectAsStateWithLifecycle()
        val deviceList = state.devices.values.toList()
        Column(
            modifier = Modifier.fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            LazyColumn(
                modifier = Modifier.fillMaxWidth(),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(
                    items = deviceList,
                    key = { it.peripheral.uuid ?: "" }
                ) { enhancedPeripheral ->
                    DeviceItem(enhancedPeripheral) { uuid, connected ->
                        Log.d("Connected State", "$connected")
                        if (connected) {
                            viewModel.onUiEvent(BluetoothUiEvent.OnDisconnect(uuid))
                        } else {
                            viewModel.onUiEvent(BluetoothUiEvent.OnConnect(uuid))
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.weight(1f))
            Button(
                onClick = {
                    viewModel.onUiEvent(BluetoothUiEvent.OnSendCommand(DeviceCommands.GET_STATUS))
                },
                modifier = Modifier.padding(64.dp)
            ) {
                Text("Get Status")
            }
        }
    } else {
        LaunchedEffect(Unit) {
            permissionsState.launchMultiplePermissionRequest()
        }
    }
}

@Composable
fun DeviceItem(
    item: EnhancedBluetoothPeripheral,
    onClick: (String?, Boolean) -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(
                onClick = { onClick(item.peripheral.uuid, item.connected) }
            ),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {
            Text(
                text = item.peripheral.name ?: "Unknown Device",
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.Bold
            )
            Text(
                text = "UUID: ${item.peripheral.uuid}",
                style = MaterialTheme.typography.bodySmall
            )
            Text(
                text = "Status: ${if (item.connected) "Connected" else "Disconnected"}",
                style = MaterialTheme.typography.bodyMedium,
                color = if (item.connected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.error
            )
        }
    }
}
