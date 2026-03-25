import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/cubits/experiment_settings_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/extensions/sensor_type_name.dart';
import 'package:uiflutter/states/bluetooth/bluetooth_states.dart';
import 'package:uiflutter/widgets/experiment_widgets/capsule_select_widget.dart';

import '../home_widgets/colored_button_widget.dart';
import '../home_widgets/uncolored_button_widget.dart';
import 'dropdown_sensor_widget.dart';

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
            insetPadding: EdgeInsets.symmetric(
              horizontal: context.dimens.paddingLarge, 
              vertical: context.dimens.paddingExtraLarge,
            ),
            backgroundColor: context.colors.secondary,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.dimens.paddingLarge,
                vertical: context.dimens.paddingLarge,
              ),
              child: Column(
                spacing: context.dimens.paddingLarge,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: context.dimens.paddingMedium,
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
                            SizedBox(
                              height: 5,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Divider(
                                    color: context.colors.primary
                                        .withValues(alpha: context.opacities.medium),
                                    height: 1,
                                    thickness: 1,
                                  )
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.strings.recording_rates_per_sec,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: context.colors.onSurface
                                    ),
                                  ),
                                  CapsuleSelectWidget(
                                    onElementClick: (element) =>
                                        context
                                            .read<ExperimentSettingsCubit>()
                                            .setRate(element.rateType),
                                    selectedValue: selectedRates.count.toInt(),
                                    elementsList: Rates.values.map((rate) => rate.count.toInt()).toList(),
                                  ),
                                ]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.strings.samples_amount_per_sec,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: context.colors.onSurface
                                    ),
                                  ),
                                  CapsuleSelectWidget(
                                    onElementClick: (element) =>
                                        context
                                            .read<ExperimentSettingsCubit>()
                                            .setSamples(element.samplesType),
                                    selectedValue: selectedSamples.count.toInt(),
                                    elementsList: Samples.values.map((samples) => samples.count.toInt()).toList(),
                                  ),
                                ]
                            ),
                          ],
                        ),
                      )
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
            )
          );
        },
      ),
    );
  }

  List<DropdownSensorWidget> getSensorsWidgetsList({
    required List<SensorType> availableSensors,
    required List<SensorType> selectedSensors,
    required void Function(SensorType) onSensorClick,
  }) {
    List<DropdownSensorWidget> widgetsList = [];
    
    final uniqueSensors = availableSensors
        .where((sensor) => sensor != SensorType.unknown)
        .map((sensor) => sensor.format)
        .toSet()
        .toList();
    
    for (var sensor in uniqueSensors) {
      final isGroupSelected = selectedSensors.any(
            (selected) => selected.format == sensor.format,
      );
      final activeSensorInGroup = selectedSensors.firstWhere(
            (selected) => selected.format == sensor.format,
        orElse: () => sensor,
      );
      
      widgetsList.add(
        DropdownSensorWidget(
          isSelected: isGroupSelected,
          sensor: activeSensorInGroup,
          onSensorClick: (sensor) => onSensorClick(sensor), 
          needDropdown: sensor.sensorsGroup.isNotEmpty,
        ),
      );
    }
    return widgetsList;
  }
}
