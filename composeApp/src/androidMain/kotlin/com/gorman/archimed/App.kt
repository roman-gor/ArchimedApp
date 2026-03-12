package com.gorman.archimed

import android.Manifest
import android.os.Build
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
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
import com.gorman.archimed.states.bluetooth.BluetoothUiEvent
import com.gorman.archimed.viewmodels.BluetoothDeviceViewModel
import com.gorman.bluetooth.constants.DeviceType
import com.gorman.bluetooth.constants.Rates
import com.gorman.bluetooth.constants.Samples
import com.gorman.bluetooth.constants.SensorType
import com.gorman.bluetooth.states.EnhancedBluetoothPeripheral
import org.koin.compose.viewmodel.koinViewModel

@OptIn(ExperimentalPermissionsApi::class)
@Suppress("LongMethod")
@Composable
fun App() {
    val permissionsState = rememberMultiplePermissionsState(
        permissions =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            listOf(
                Manifest.permission.BLUETOOTH,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION,
                Manifest.permission.BLUETOOTH_CONNECT,
                Manifest.permission.BLUETOOTH_SCAN
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
            modifier = Modifier
                .fillMaxSize()
                .padding(top = 16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = when (state.selectedDeviceType) {
                    DeviceType.ECOLOGY -> "Ecology"
                    DeviceType.PHYSICS -> "Physics"
                    DeviceType.BIOLOGY -> "Biology"
                    DeviceType.PHYSIOLOGY -> "Physiology"
                    DeviceType.UNKNOWN -> "Archimed"
                    else -> ""
                },
                style = MaterialTheme.typography.titleLarge,
                modifier = Modifier.padding(bottom = 16.dp)
            )

            LazyColumn(
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(
                    items = deviceList,
                    key = { it.peripheral.uuid }
                ) { enhancedPeripheral ->
                    DeviceItem(enhancedPeripheral) { uuid, connected ->
                        if (connected) {
                            viewModel.onUiEvent(BluetoothUiEvent.OnDisconnect(uuid))
                        } else {
                            viewModel.onUiEvent(BluetoothUiEvent.OnConnect(uuid))
                        }
                    }
                }

                item {
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 16.dp),
                        horizontalAlignment = Alignment.CenterHorizontally,
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Text(text = state.statusDeviceData.toString())
                        Spacer(
                            modifier = Modifier.fillMaxWidth().height(
                                2.dp
                            ).background(MaterialTheme.colorScheme.onBackground)
                        )
                        Text(text = state.experimentOnlineDataState.toString())
                        Spacer(
                            modifier = Modifier.fillMaxWidth().height(
                                2.dp
                            ).background(MaterialTheme.colorScheme.onBackground)
                        )
                        Text(text = state.experimentsHistoryDataState.toString())
                        Spacer(
                            modifier = Modifier.fillMaxWidth().height(
                                2.dp
                            ).background(MaterialTheme.colorScheme.onBackground)
                        )
                        Text(text = state.singleExperimentDataState.toString())
                        Spacer(
                            modifier = Modifier.fillMaxWidth().height(
                                2.dp
                            ).background(MaterialTheme.colorScheme.onBackground)
                        )
                    }
                }

                item {
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(bottom = 16.dp),
                        horizontalAlignment = Alignment.CenterHorizontally,
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.StartDefaultLogging)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Start all sensors logging") }
                        Button(onClick = {
                            viewModel.onUiEvent(
                                BluetoothUiEvent.OnSendCommand(
                                    BluetoothUiEvent.DeviceCommand.StartLogging(
                                        listOf(SensorType.ACCELEROMETER_MEDIUM_SENSITIVE),
                                        sampleRate = Rates.RATE_100_PER_SEC,
                                        sampleCount = Samples.SAMPLES_1000,
                                        shouldCalibrate = false
                                    )
                                )
                            )
                        }, modifier = Modifier.fillMaxWidth()) { Text("Start sensor logging") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.StopLogging)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Stop sensor logging") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.DeleteLastRecording)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Delete last recording") }

                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            Button(
                                onClick = {
                                    viewModel.onUiEvent(
                                        BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.GetExperimentsList)
                                    )
                                },
                                modifier = Modifier.weight(1f)
                            ) { Text("Download INFO", maxLines = 1) }
                            Button(
                                onClick = {
                                    viewModel.onUiEvent(
                                        BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.SendNextDataPackage)
                                    )
                                },
                                modifier = Modifier.weight(1f)
                            ) { Text("Get NEXT", maxLines = 1) }
                        }

                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(
                                        BluetoothUiEvent.DeviceCommand.GetExperimentData(1)
                                    )
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Download STORE DATA") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.TerminateDownloading)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Terminate DOWNLOADING") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.GetAllSensorsId)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Get All Sensors Ids") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.GetSensorsValues)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Get Sensors Values") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.ClearDeviceMemory)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Clear ALL SAMPLES") }
                        Button(
                            onClick = {
                                viewModel.onUiEvent(
                                    BluetoothUiEvent.OnSendCommand(BluetoothUiEvent.DeviceCommand.SetCurrentDateTime)
                                )
                            },
                            modifier = Modifier.fillMaxWidth()
                        ) { Text("Set DATE TIME") }
                    }
                }
            }
        }
    } else {
        LaunchedEffect(Unit) {
            permissionsState.launchMultiplePermissionRequest()
        }
        Box {
            Text(text = "Text")
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
