import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_ui_event.dart';
import 'package:uiflutter/widgets/experiment_widgets/chart_widget.dart';
import 'package:uiflutter/widgets/experiment_widgets/table_widget.dart';

import '../cubits/bluetooth_cubit.dart';
import '../states/bluetooth/bluetooth_states.dart';
import '../widgets/experiment_widgets/sensors_block_widget.dart';

class ExperimentView extends StatefulWidget {
  const ExperimentView({
    super.key,
    this.experimentId = 0,
    this.isOnlineExperiment = false,
    this.sensors = const [],
    this.sampleRate = Rates.rate10PerSec,
    this.samplesCount = Samples.samples100,
  });

  final int experimentId;
  final bool isOnlineExperiment;
  final List<SensorType> sensors;
  final Rates sampleRate;
  final Samples samplesCount;

  @override
  State<StatefulWidget> createState() => ExperimentViewState();
}

class ExperimentViewState extends State<ExperimentView> {
  bool _isTableViewSelected = false;
  late bool _isOnlineData;

  @override
  void initState() {
    final bluetoothCubit = context.read<BluetoothCubit>();
    _isOnlineData = widget.isOnlineExperiment;
    if (_isOnlineData) {
      bluetoothCubit.sendCommand(
        BluetoothUiEvent.onSendCommand(
          DeviceCommand.startLogging(
            widget.sensors,
            widget.sampleRate,
            widget.samplesCount,
            false,
          ),
        ),
      );
    } else {
      bluetoothCubit.sendCommand(
        BluetoothUiEvent.onSendCommand(
          DeviceCommand.getExperimentData(widget.experimentId),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.secondary,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          top: false,
          child: BlocBuilder<BluetoothCubit, BluetoothDeviceState?>(
            builder: (context, bluetoothState) {
              final isOnlineLoading = bluetoothState?.isOnlineDataLoading ?? false;
              final experimentData = bluetoothState?.experimentData ?? ExperimentsData();
              final experimentOnlineData = bluetoothState?.experimentOnlineData 
                  ?? ExperimentOnlineData();
              final isExperimentLoading =
                  bluetoothState?.isExperimentLoading ?? true;
              if (isExperimentLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              final sensorsData = _isOnlineData
                  ? experimentOnlineData.sensorsData
                  : experimentData.sensorsData;

              final activeSensors = _isOnlineData
                  ? experimentOnlineData.sensorsData.keys.toList()
                  : experimentData.activeSensors;

              final actualSensor = bluetoothState?.selectedSensor ??
                  (activeSensors.isNotEmpty ? activeSensors.first : SensorType.unknown);

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
                                  sensors: activeSensors,
                                  selectedSensor:
                                      bluetoothState?.selectedSensor ??
                                      SensorType.unknown,
                                  onSensorClick: (sensor) {
                                    context.read<BluetoothCubit>().selectSensor(
                                      sensor,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: context.dimens.paddingExtraLarge),
                              if (isOnlineLoading) ...[
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<BluetoothCubit>()
                                      .sendCommand(
                                        BluetoothUiEvent.onSendCommand(
                                          DeviceCommand.stopLogging(),
                                        ),
                                      ),
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                      color: Colors.red.withValues(
                                        alpha: context.opacities.medium,
                                      ),
                                    ),
                                    backgroundColor: Colors.red.withValues(
                                      alpha: context.opacities.low,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                    minimumSize: const Size(120, 44),
                                  ),
                                  child: Text(
                                    context.strings.stop,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                ElevatedButton(
                                  onPressed: () {
                                    _isOnlineData = true;
                                    context.read<BluetoothCubit>().sendCommand(
                                      BluetoothUiEvent.onSendCommand(
                                        DeviceCommand.startLogging(
                                          experimentData.activeSensors,
                                          experimentData.sampleRate ??
                                              Rates.rate10PerSec,
                                          experimentData.samplesCount ??
                                              Samples.samples100,
                                          false,
                                        ),
                                      ),
                                    );
                                  },
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
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Expanded(
                            child: _isTableViewSelected
                                ? TableWidget(sensorsData: sensorsData)
                                : ChartWidget(
                                    sensorsData: sensorsData,
                                    currentSensor: actualSensor,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.dimens.paddingLarge),
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
                          icon: _isTableViewSelected
                              ? Icons.table_chart_outlined
                              : Icons.stacked_line_chart_outlined,
                          onPressed: () => setState(
                            () => _isTableViewSelected = !_isTableViewSelected,
                          ),
                        ),
                        _manageButtonWidget(
                          context: context,
                          icon: Icons.settings_outlined,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _manageButtonWidget({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
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
          elevation: 4,
        ),
      ),
    );
  }
}
