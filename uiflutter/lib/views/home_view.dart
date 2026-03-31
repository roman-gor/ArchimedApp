import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uiflutter/data/bluetooth_cubit.dart';
import 'package:uiflutter/data/permissions_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/permissions_state.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/tools_block.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import '../states/bluetooth/bluetooth_ui_event.dart';
import '../widgets/home_widgets/devices_select_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late final PermissionsCubit _permissionsCubit;
  late final BluetoothCubit _bluetoothCubit;

  @override
  void initState() {
    super.initState();

    _permissionsCubit = PermissionsCubit();
    _bluetoothCubit = BluetoothCubit();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _permissionsCubit.close();
    _bluetoothCubit.close();
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

    final backgroundImage = isDark
        ? 'assets/images/bg_dark.png'
        : 'assets/images/bg_light.png';

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _permissionsCubit),
        BlocProvider.value(value: _bluetoothCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PermissionsCubit, PermissionsState>(
            listener: (context, permissionState) {
              if (permissionState is PermissionsDenied) {
                showPermissionExplanationDialog(context);
              }
            },
          ),
          BlocListener<BluetoothCubit, BluetoothDeviceState?>(
            listener: (context, bluetoothState) {
              if (bluetoothState == null) return;

              final device =
                  bluetoothState.devices[bluetoothState.selectedDeviceId];
              device?.connectedState.maybeWhen(
                disconnected: (reason) {
                  reason?.maybeWhen(
                    unknown: (code) {
                      if (code == 147) {
                        Fluttertoast.showToast(
                          msg: context.strings.could_not_connect,
                          backgroundColor: context.colors.surface,
                          textColor: context.colors.onSurface,
                        );
                      }
                    },
                    orElse: () {},
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
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
              child: BlocBuilder<BluetoothCubit, BluetoothDeviceState?>(
                builder: (context, bluetoothState) {
                  final currentDevice =
                      bluetoothState?.devices[bluetoothState.selectedDeviceId];
                  final bool isDeviceSelected =
                      bluetoothState?.selectedDeviceId != null;

                  return BlocBuilder<PermissionsCubit, PermissionsState>(
                    builder: (context, permissionsState) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                          top: 22,
                        ),
                        child: Column(
                          spacing: 8,
                          children: [
                            DeviceStatusWidget(
                              selectedDeviceType:
                                  bluetoothState?.selectedDeviceType,
                              currentDevice: currentDevice,
                              onListClick: () {
                                if (permissionsState
                                    is PermissionsPermanentlyDenied) {
                                  showBluetoothDeniedDialog(context);
                                } else if (permissionsState
                                    is PermissionsDenied) {
                                  showPermissionExplanationDialog(context);
                                } else {
                                  _bluetoothCubit.sendCommand(
                                    BluetoothUiEvent.onStartScan(),
                                  );
                                  showDevicesSelectedDialog(
                                    context,
                                    onDeviceClick: (String deviceId) {
                                      _bluetoothCubit.sendCommand(
                                        BluetoothUiEvent.onConnect(deviceId),
                                      );
                                    },
                                    currentState: bluetoothState,
                                  );
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
                                      isDeviceConnected: isDeviceSelected,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
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
      },
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
      },
    );
  }

  void showDevicesSelectedDialog(
    BuildContext context, {
    required void Function(String) onDeviceClick,
    required BluetoothDeviceState? currentState,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocBuilder<BluetoothCubit, BluetoothDeviceState?>(
          bloc: _bluetoothCubit,
          builder: (context, state) {
            if (state == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return DevicesSelectDialog(
              availableDevices: state.devices,
              onDeviceClick: onDeviceClick,
              selectedDeviceId: state.selectedDeviceId, 
              selectedDeviceType: state.selectedDeviceType,
            );
          },
        );
      },
    ).then((value) {
      _bluetoothCubit.sendCommand(BluetoothUiEvent.onStopScan());
    });
  }
}
