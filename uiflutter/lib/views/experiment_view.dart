import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_ui_event.dart';

import '../data/bluetooth_cubit.dart';
import '../states/bluetooth/bluetooth_states.dart';
import '../widgets/experiment_widgets/sensors_block_widget.dart';

class ExperimentView extends StatefulWidget {
  const ExperimentView({super.key, required this.experimentId});

  final int experimentId;

  @override
  State<StatefulWidget> createState() => ExperimentViewState();
}

class ExperimentViewState extends State<ExperimentView> {
  late final BluetoothCubit _bluetoothCubit;
  
  SensorType currentSensor = SensorType.unknown;

  @override
  void initState() {
    _bluetoothCubit = BluetoothCubit();
    _bluetoothCubit.sendCommand(
      BluetoothUiEvent.onSendCommand(
        DeviceCommand.getExperimentData(widget.experimentId),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bluetoothCubit,
      child: Container(
        color: context.colors.secondary,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            top: false,
            child: BlocBuilder<BluetoothCubit, BluetoothDeviceState?>(
              builder: (context, bluetoothState) {
                final experimentData =
                    bluetoothState?.experimentData ?? ExperimentsData();
                final isExperimentLoading =
                    bluetoothState?.isExperimentLoading ?? true;
                if (isExperimentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Padding(
                  padding: EdgeInsets.only(
                    left: context.dimens.paddingExtraLarge,
                    right: context.dimens.paddingExtraLarge,
                    bottom: context.dimens.paddingExtraLarge,
                    top: 40,
                  ),
                  child: Row(
                    spacing: context.dimens.paddingLarge,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: context.dimens.paddingLarge,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SensorsBlockWidget(
                                    sensors: experimentData.activeSensors,
                                    selectedSensor: bluetoothState?.selectedSensor ?? SensorType.unknown,
                                    onSensorClick: (sensor) { _bluetoothCubit.selectSensor(sensor); },
                                  ),
                                ),
                                SizedBox(width: context.dimens.paddingExtraLarge,),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.colors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                    minimumSize: const Size(120, 44),
                                  ),
                                  child: Text(
                                    context.strings.again,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: const Center(child: Text("Здесь будет график")),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: context.dimens.paddingLarge,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        spacing: context.dimens.paddingLarge,
                        children: [
                          _manageButtonWidget(
                            context: context,
                            icon: Icons.house_outlined,
                            onPressed: () => Navigator.pop(context),
                          ),
                          _manageButtonWidget(
                            context: context,
                            icon: Icons.color_lens_outlined,
                            onPressed: () {},
                          ),
                          _manageButtonWidget(
                            context: context,
                            icon: Icons.stacked_line_chart_outlined,
                            onPressed: () {},
                          ),
                          _manageButtonWidget(
                            context: context,
                            icon: Icons.settings_outlined,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _manageButtonWidget({
    required BuildContext context, 
    required IconData icon,
    required VoidCallback onPressed
  }) {
    return SizedBox(
      width: 50,
      height: 50,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: 30,
        color: context.colors.onSurface,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: context.colors.tertiary,
          shape: const CircleBorder(),
          elevation: 4
        )
      ),
    );
  }
}
