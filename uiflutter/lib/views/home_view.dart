import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uiflutter/l10n/app_localizations.dart';
import 'package:uiflutter/widgets/home_widgets/colored_button_widget.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/tools_block.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  bool _hasPermissions = false;

  static const EventChannel _eventChannel = EventChannel('com.gorman.archimed/events');

  Stream<String>? _bluetoothDataState;

  bool _isDeviceSelected = false;

  @override
  void initState() {
    super.initState();
    checkInitialPermissions();
    _bluetoothDataState = _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event as String);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  DeviceStatusWidget(isDeviceSelected: _isDeviceSelected),
                  Expanded(
                    child: Row(
                      spacing: 8,
                      children: [
                        ToolsBlock(),
                        Expanded(
                            child: ManagingBlockWidget(isDeviceConnected: _isDeviceSelected)
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

  Future<void> checkInitialPermissions() async {
    var status = await Permission.bluetoothConnect.status;
    if (status.isGranted) {
      setState(() {
        _hasPermissions = true;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPermissionExplanationDialog(context);
      });
    }
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetooth,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetoothScan]!.isGranted &&
        statuses[Permission.bluetoothConnect]!.isGranted &&
        statuses[Permission.location]!.isGranted) {

      setState(() {
        _hasPermissions = true;
      });
    } else {
    }
  }

  void showPermissionExplanationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DefaultDialogWidget(
            icon: Icons.bluetooth,
            text: AppLocalizations.of(context)!.allow_bluetooth_desc,
            dismissText: AppLocalizations.of(context)!.back,
            confirmText: AppLocalizations.of(context)!.allow,
            onConfirm: () {
              requestPermissions();
              Navigator.of(context).pop();
            },
            onDismiss: () => Navigator.of(context).pop(),
          );
        }
    );
  }
}
