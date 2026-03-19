import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uiflutter/l10n/app_localizations.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/tools_block.dart';

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

  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');

  Stream<String>? _bluetoothDataState;

  bool _isDeviceSelected = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bluetoothDataState = _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as String);
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
            child: Padding(
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
                      isDeviceSelected: _isDeviceSelected,
                      onListClick: () {
                        if (_wasPermanentlyDenied && !_hasPermissions) {
                          showBluetoothDeniedDialog(context);
                        } else if (!_wasPermanentlyDenied && !_hasPermissions) {
                          showPermissionExplanationDialog(context);
                        } else {
                          showDevicesSelectedDialog(context);
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
                                  isDeviceConnected: _isDeviceSelected)
                          )
                        ],
                      ),
                    )
                  ],
                )
            ),
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

  void showDevicesSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DevicesSelectDialog();
      },
    );
  }
}

