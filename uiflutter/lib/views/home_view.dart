import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uiflutter/cubits/bluetooth_cubit.dart';
import 'package:uiflutter/cubits/home_tabs_cubit.dart';
import 'package:uiflutter/cubits/permissions_cubit.dart';
import 'package:uiflutter/cubits/theme_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/navigation/navigator_local.dart';
import 'package:uiflutter/states/permissions_state.dart';
import 'package:uiflutter/views/experiment_view.dart';
import 'package:uiflutter/widgets/home_widgets/default_dialog_widget.dart';
import 'package:uiflutter/widgets/home_widgets/device_status_widget.dart';
import 'package:uiflutter/widgets/home_widgets/managing_block_widget.dart';
import 'package:uiflutter/widgets/home_widgets/theme_tab_widget.dart';
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
  late final HomeTabsCubit _homeTabsCubit;
  late final ThemeCubit _themeCubit;

  @override
  void initState() {
    super.initState();

    _permissionsCubit = PermissionsCubit();
    _bluetoothCubit = BluetoothCubit();
    _homeTabsCubit = HomeTabsCubit();
    _themeCubit = ThemeCubit();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _permissionsCubit.close();
    _bluetoothCubit.close();
    _homeTabsCubit.close();
    _themeCubit.close();
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
        BlocProvider.value(value: _homeTabsCubit),
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
              _bluetoothCubit.observeConnectionState(
                    device?.connectedState, 
                    () => Fluttertoast.showToast(
                      msg: context.strings.could_not_connect,
                      backgroundColor: context.colors.surface,
                      textColor: context.colors.onSurface,
                    ),
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

                  return BlocBuilder<PermissionsCubit, PermissionsState>(
                    builder: (context, permissionsState) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: context.dimens.paddingLarge,
                          right: context.dimens.paddingLarge,
                          bottom: context.dimens.paddingLarge,
                          top: context.dimens.paddingExtraLarge,
                        ),
                        child: Column(
                          spacing: context.dimens.paddingMedium,
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
                              child: BlocBuilder<HomeTabsCubit, HomeTabs>(
                                builder: (context, currentTab) {
                                  return Row(
                                    spacing: context.dimens.paddingMedium,
                                    children: [
                                      ToolsBlock(
                                        selectedTab: currentTab,
                                        onTabClick: (tab) {
                                          _homeTabsCubit.switchTab(tab);
                                        },
                                      ),
                                      Expanded(
                                        child: IndexedStack(
                                          index: currentTab.index,
                                          children: [
                                            ManagingBlockWidget(
                                              isDeviceConnected: _bluetoothCubit.isDeviceConnected,
                                              isExperimentLoading: bluetoothState?.isExperimentLoading ?? true,
                                              deviceType: bluetoothState?.selectedDeviceType,
                                              experimentsHistoryList: bluetoothState?.experimentsHistoryData.reversed.toList(),
                                              onExperimentClick: (id) => NavigatorLocal.goTo(
                                                BlocProvider.value(
                                                  value: context.read<BluetoothCubit>(),
                                                  child: ExperimentView(experimentId: id),
                                                )
                                              ),
                                              onStartExperiment: () => NavigatorLocal.goTo(
                                                  BlocProvider.value(
                                                    value: context.read<BluetoothCubit>(),
                                                    child: ExperimentView(
                                                      isOnlineExperiment: true,
                                                      sensors: [SensorType.airPressure, SensorType.accelerometer4g],
                                                    ),
                                                  )
                                              ),
                                              onClearMemory: () => _bluetoothCubit.sendCommand(
                                                BluetoothUiEvent.onSendCommand(
                                                  DeviceCommand.clearDeviceMemory()
                                                )
                                              )
                                            ),
                                            _buildMaterialsTab(),
                                            _buildDocsTab(),
                                            ThemeTabWidget(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
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

  Widget _buildMaterialsTab() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: context.colors.surface,
      ),
      child: const Center(child: Text("Materials Tab Content")),
    );
  }

  Widget _buildDocsTab() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: context.colors.surface,
          ),
          child: const Center(child: Text("Docs Content")),
        );
      },
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
            NavigatorLocal.goBack();
          },
          onDismiss: () => NavigatorLocal.goBack()
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
            NavigatorLocal.goBack();
          },
          onDismiss: () => NavigatorLocal.goBack()
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
              onCloseDialog: () => NavigatorLocal.goBack(),
            );
          },
        );
      },
    ).then((value) {
      _bluetoothCubit.sendCommand(BluetoothUiEvent.onStopScan());
    });
  }
}
