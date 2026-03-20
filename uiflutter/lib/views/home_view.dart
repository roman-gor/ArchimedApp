import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:uiflutter/l10n/app_localizations.dart';
import 'package:uiflutter/utils/method_channel_commands.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/tools_block.dart';
import 'dart:convert';
import 'package:uiflutter/states/bluetooth_states.dart';
import '../utils/permission_processing.dart';
import '../widgets/home_widgets/devices_select_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with WidgetsBindingObserver {

  bool _hasPermissions = false;
  bool _wasPermanentlyDenied = false;

  var logger = Logger();

  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');
  static const MethodChannel _methodChannel = MethodChannel('com.gorman.archimed/methods');

  Stream<BluetoothDeviceState>? _bluetoothDataState;

  @override
  void initState() {
    super.initState();
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
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkInitialPermissions(
        onAllGranted: () {
          setState(() {
            _hasPermissions = true;
            _wasPermanentlyDenied = false;
          });
        },
        onPermanentlyDenied: () {
          setState(() {
            _hasPermissions = false;
            _wasPermanentlyDenied = true;
          });
        },
        onOtherCases: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showPermissionExplanationDialog(context);
          });
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    final backgroundImage = isDark
        ? 'assets/images/bg_dark.png'
        : 'assets/images/bg_light.png';

    return Container(
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
                    child: Text('Channel error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
                  );
                }

                final state = snapshot.data;
                final bool isDeviceSelected = state?.selectedDeviceId != null;

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
                          selectedDeviceId: state?.selectedDeviceId,
                          selectedDeviceType: state?.selectedDeviceType,
                          isDeviceSelected: isDeviceSelected,
                          onListClick: () async {
                            if (_wasPermanentlyDenied && !_hasPermissions) {
                              showBluetoothDeniedDialog(context);
                            } else if (!_wasPermanentlyDenied && !_hasPermissions) {
                              showPermissionExplanationDialog(context);
                            } else {
                              try {
                                _methodChannel.invokeMethod(MethodChannelCommands.startScan.name);
                              } on PlatformException catch (e) {
                                logger.e("Method Channel Start Scan error ${e.message}");
                              }
                              showDevicesSelectedDialog(
                                  context,
                                  currentState: state,
                                  onDeviceClick: (String deviceId) {  });
                            }
                          },
                        ),
                        Expanded(
                          child: Row(
                            spacing: 8,
                            children: [
                              ToolsBlock(),
                              Expanded(
                                  child: ManagingBlockWidget(isDeviceConnected: isDeviceSelected)
                              )
                            ],
                          ),
                        )
                      ],
                    )
                );
              },
            )
          ),
        )
    );
  }

  void showPermissionExplanationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialogWidget(
            icon: Icons.bluetooth,
            bgColor: Theme
                .of(context)
                .colorScheme
                .primary,
            text: AppLocalizations.of(context)!.allow_bluetooth_desc,
            dismissText: AppLocalizations.of(context)!.back,
            confirmText: AppLocalizations.of(context)!.allow,
            onConfirm: () {
              requestPermissions(
                onAllGranted: () {
                  setState(() {
                    _hasPermissions = true;
                    _wasPermanentlyDenied = false;
                  });
                },
                onPermanentlyDenied: () {
                  setState(() {
                    _hasPermissions = false;
                    _wasPermanentlyDenied = true;
                  });
                },
                onOtherCases: () {
                  setState(() {
                    _hasPermissions = false;
                    _wasPermanentlyDenied = false;
                  });
                },
              );
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
            text: AppLocalizations.of(context)!.permissions_denied,
            dismissText: AppLocalizations.of(context)!.back,
            confirmText: AppLocalizations.of(context)!.allow,
            onConfirm: () {
              requestPermissions(
                onAllGranted: () {
                  setState(() {
                    _hasPermissions = true;
                    _wasPermanentlyDenied = false;
                  });
                },
                onPermanentlyDenied: () {
                  setState(() {
                    _hasPermissions = false;
                    _wasPermanentlyDenied = true;
                  });
                },
                onOtherCases: () {
                  setState(() {
                    _hasPermissions = false;
                    _wasPermanentlyDenied = false;
                  });
                },
              );
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
                  selectedDeviceType: state.selectedDeviceType,
                  selectedDeviceId: state.selectedDeviceId,
                  onDeviceClick: onDeviceClick,
                  onCloseDialog: () => Navigator.of(dialogContext).pop(),
                );
              }
          );
        }
    ).then( (value) async {
      try {
        _methodChannel.invokeMethod(MethodChannelCommands.stopScan.name);
      } on PlatformException catch (e) {
        logger.e("Method Channel Start Scan error ${e.message}");
      }
    });
  }
}

