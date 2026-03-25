import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/cubits/experiment_settings_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import 'package:uiflutter/widgets/experiment_widgets/sensor_button_widget.dart';

import '../../navigation/navigator_local.dart';
import '../home_widgets/colored_button_widget.dart';
import '../home_widgets/uncolored_button_widget.dart';

class StartExperimentDialog extends StatelessWidget {
  const StartExperimentDialog({
    super.key,
    required this.availableSensors,
    required this.onDismiss,
    required this.onStart,
  });

  final List<SensorType> availableSensors;
  final VoidCallback onDismiss;
  final void Function(ExperimentSettings) onStart;
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExperimentSettingsCubit(),
      child: BlocBuilder<ExperimentSettingsCubit, ExperimentSettings>(
        builder: (context, experimentSettings) {
          final selectedSensors = experimentSettings.sensors;
          final selectedSamples = experimentSettings.samplesCount;
          final selectedRates = experimentSettings.sampleRate;
          return Dialog(
            backgroundColor: context.colors.secondary,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Column(
              spacing: context.dimens.paddingLarge,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  spacing: context.dimens.paddingMedium,
                  runSpacing: context.dimens.paddingMedium,
                  children: getSensorsWidgetsList(
                      availableSensors: availableSensors,
                      selectedSensors: selectedSensors,
                      onSensorClick: (sensor) => context.read<ExperimentSettingsCubit>().setSensors(sensor)
                  ),
                ),
                Row(
                  spacing: context.dimens.paddingLarge,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UncoloredButtonWidget(
                      text: context.strings.back,
                      onPressed: onDismiss,
                    ),
                    ColoredButtonWidget(
                      text: context.strings.start,
                      onPressed: () => onStart(experimentSettings),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<SensorButtonWidget> getSensorsWidgetsList({
    required List<SensorType> availableSensors,
    required List<SensorType> selectedSensors,
    required void Function(SensorType) onSensorClick,
  }) {
    List<SensorButtonWidget> widgetsList = [];
    for (var sensor in availableSensors.where((sensor) => sensor != SensorType.unknown)) {
      widgetsList.add(
        SensorButtonWidget(
          isSelected: selectedSensors.contains(sensor),
          sensor: sensor,
          onSensorClick: (sensor) => onSensorClick(sensor),
        ),
      );
    }
    return widgetsList;
  }
}
