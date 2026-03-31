import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/data/permissions_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/permissions_state.dart';
import 'package:logger/logger.dart';
import 'package:uiflutter/utils/method_channel_commands.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/tools_block.dart';
import 'dart:convert';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import '../states/bluetooth/bluetooth_ui_event.dart';
import '../widgets/home_widgets/devices_select_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with WidgetsBindingObserver {

  var logger = Logger();
  
  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');
  static const MethodChannel _methodChannel = MethodChannel('com.gorman.archimed/methods');
  
  Stream<BluetoothDeviceState>? _bluetoothDataState;

  late final PermissionsCubit _permissionsCubit;

  @override
  void initState() {
    super.initState();
    
    _permissionsCubit = PermissionsCubit();
    
    WidgetsBinding.instance.addObserver(this);
    _bluetoothDataState = _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) {
          final String jsonString = event as String;
          final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
          return BluetoothDeviceState.fromJson(jsonMap);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _permissionsCubit.close();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _permissionsCubit.checkInitialPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.themes.brightness == Brightness.dark;

    final backgroundImage = isDark ? 'assets/images/bg_dark.png' : 'assets/images/bg_light.png';

    return BlocProvider.value(
        value: _permissionsCubit,
        child: BlocListener<PermissionsCubit, PermissionsState>(
            listener: (context, permissionState) {
              if (permissionState is PermissionsDenied) {
                showPermissionExplanationDialog(context);
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                        bottom: false,
                        top: false,
                        child: StreamBuilder<BluetoothDeviceState>(
                            stream: _bluetoothDataState,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                      'Channel error: ${snapshot.error}',
                                      style: const TextStyle(color: Colors
                                          .red)),
                                );
                              }

                              final bluetoothState = snapshot.data;
                              final EnhancedBluetoothPeripheral? currentDevice = bluetoothState
                                  ?.devices[bluetoothState.selectedDeviceId];
                              final bool isDeviceSelected = bluetoothState
                                  ?.selectedDeviceId != null;

                              return BlocBuilder<PermissionsCubit, PermissionsState>(
                                builder: (context, permissionsState) {
                                  return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 22
                                      ),
                                      child: Column(
                                        spacing: 8,
                                        children: [
                                          DeviceStatusWidget(
                                            selectedDeviceType: bluetoothState?.selectedDeviceType,
                                            currentDevice: currentDevice,
                                            onListClick: () async {
                                              if (permissionsState is PermissionsPermanentlyDenied) {
                                                showBluetoothDeniedDialog(context);
                                              } else
                                              if (permissionsState is PermissionsDenied) {
                                                showPermissionExplanationDialog(context);
                                              } else {
                                                try {
                                                  _methodChannel.invokeMethod(
                                                      MethodChannelCommands.onUiEvent.name, 
                                                      <String, String> {
                                                        "command": jsonEncode(BluetoothUiEvent.onStartScan().toJson())
                                                      }
                                                  );
                                                } on PlatformException catch (e) {
                                                  logger.e("Method Channel Start Scan error ${e.message}");
                                                } 
                                                showDevicesSelectedDialog(
                                                    context,
                                                    currentState: bluetoothState,
                                                    onDeviceClick: (String deviceId) {
                                                      _methodChannel.invokeMethod(
                                                          MethodChannelCommands.onUiEvent.name,
                                                          <String, String> {
                                                            "command": jsonEncode(BluetoothUiEvent.onConnect(deviceId).toJson())
                                                          }
                                                      );
                                                    });
                                              }
                                            },
                                          ),
                                          Expanded(
                                            child: Row(
                                              spacing: 8,
                                              children: [
                                                ToolsBlock(),
                                                Expanded(
                                                    child: ManagingBlockWidget(
                                                        isDeviceConnected: isDeviceSelected)
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  );
                                },
                              );
                            }
                        )
                    )
                )
            )
        )
    );
  }

  void showPermissionExplanationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialogWidget(
            icon: Icons.bluetooth,
            bgColor: context.colors.primary,
            text: context.strings.allow_bluetooth_desc,
            dismissText: context.strings.back,
            confirmText: context.strings.allow,
            onConfirm: () {
              _permissionsCubit.requestPermissions();
              Navigator.of(context).pop();
            },
            onDismiss: () => Navigator.of(context).pop(),
          );
        }
    );
  }

  void showBluetoothDeniedDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialogWidget(
            icon: Icons.bluetooth_disabled,
            bgColor: Colors.red,
            text: context.strings.permissions_denied,
            dismissText: context.strings.back,
            confirmText: context.strings.allow,
            onConfirm: () {
              _permissionsCubit.requestPermissions();
              Navigator.of(context).pop();
            },
            onDismiss: () => Navigator.of(context).pop(),
          );
        }
    );
  }

  void showDevicesSelectedDialog(BuildContext context, {
    required void Function(String) onDeviceClick,
    required BluetoothDeviceState? currentState,
  }) {
    showDialog(
      context: context,
        builder: (BuildContext dialogContext) {
          return StreamBuilder<BluetoothDeviceState>(
              stream: _bluetoothDataState,
              initialData: currentState,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final state = snapshot.data!;

                return DevicesSelectDialog(
                  availableDevices: state.devices,
                  onDeviceClick: onDeviceClick,
                );
              }
          );
        }
    ).then( (value) async {
      try {
        _methodChannel.invokeMethod(
            MethodChannelCommands.onUiEvent.name,
            <String, String> {
              "command": jsonEncode(BluetoothUiEvent.onStopScan().toJson())
            }
        );
      } on PlatformException catch (e) {
        logger.e("Method Channel Stop Scan error ${e.message}");
      }
    });
  }
}

