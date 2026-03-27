import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uiflutter/cubits/experiment_ui_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_ui_event.dart';
import 'package:uiflutter/widgets/experiment_widgets/chart_widget.dart';
import 'package:uiflutter/widgets/experiment_widgets/table_widget.dart';

import '../cubits/bluetooth_cubit.dart';
import '../states/bluetooth/sensor_types.dart';
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
  late ExperimentUiCubit _experimentUiCubit;

  @override
  void initState() {
    final bluetoothCubit = context.read<BluetoothCubit>();
    _isOnlineData = widget.isOnlineExperiment;
    _experimentUiCubit = ExperimentUiCubit(
      bluetoothCubit: bluetoothCubit, 
      isOnlineData: _isOnlineData,
    );
    initStateData(bluetoothCubit);
    super.initState();
  }

  void initStateData(BluetoothCubit bluetoothCubit) {
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
  }
  
  @override
  void dispose() {
    _experimentUiCubit.close();
    super.dispose();
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
          child: BlocProvider(
            create: (context) => _experimentUiCubit,
            child: BlocBuilder<ExperimentUiCubit, ExperimentUiState>(
              builder: (context, state) => _buildExperimentViewContent(context, state),
            ),
          )
        ),
      ),
    );
  }

  Widget _buildExperimentViewContent(BuildContext context, ExperimentUiState state) {
    if (state.isExperimentDataLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.only(
        left: context.dimens.paddingExtraLarge,
        right: context.dimens.paddingExtraLarge,
        bottom: context.dimens.paddingExtraLarge,
        top: context.dimens.sizeMedium,
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
                        sensors: state.activeSensors,
                        selectedSensor:
                        state.actualSensor,
                        onSensorClick: (sensor) {
                          context.read<BluetoothCubit>().selectSensor(
                            sensor,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: context.dimens.paddingExtraLarge),
                    if (state.isOnlineLoading) ...[
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
                          minimumSize: Size(120, context.dimens.sizeMedium),
                        ),
                        child: Text(
                          context.strings.stop,
                          style: context.textStyle.bodyLarge?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () {
                          setState(() => _isOnlineData = true);
                          _experimentUiCubit.setOnlineMode(true);
                          context.read<BluetoothCubit>().sendCommand(
                            BluetoothUiEvent.onSendCommand(
                              DeviceCommand.startLogging(
                                state.activeSensors,
                                state.sampleRate ?? Rates.rate10PerSec,
                                state.samplesCount ?? Samples.samples100,
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
                          minimumSize: Size(120, context.dimens.sizeMedium),
                        ),
                        child: Text(
                          context.strings.again,
                          style: context.textStyle.bodyLarge?.copyWith(
                            color: Colors.white,
                          )
                        ),
                      ),
                    ],
                  ],
                ),
                Expanded(
                  child: state.sensorsData.isEmpty
                      ? _shimmerWidget(context)
                      : _isTableViewSelected
                      ? TableWidget(sensorsData: state.sensorsData)
                      : ChartWidget(
                    sensorsData: state.sensorsData,
                    currentSensor: state.actualSensor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.dimens.paddingLarge),
          _buildToolsBlock(context),
        ],
      ),
    );
  }

  Column _buildToolsBlock(BuildContext context) {
    return Column(
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
          onPressed: () =>
              setState(() => _isTableViewSelected = !_isTableViewSelected),
        ),
        _manageButtonWidget(
          context: context,
          icon: Icons.settings_outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _manageButtonWidget({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: context.dimens.sizeMedium + 10,
      height: context.dimens.sizeMedium + 10,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        iconSize: context.dimens.sizeSmall,
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

  Widget _shimmerWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SvgPicture.asset("assets/images/ic_shimmer.svg"),
    );
  }
}
