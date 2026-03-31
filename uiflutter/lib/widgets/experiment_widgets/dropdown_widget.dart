import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';
import '../../extensions/measures_unit_extensions.dart';
import '../../extensions/sensor_type_extensions.dart';
import '../../states/bluetooth/sensor_types.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key, 
    required this.sensor, 
    required this.backgroundColor, 
    required this.onSensorClick
  });
  
  final SensorType sensor;
  final Color backgroundColor;
  final void Function(SensorType) onSensorClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dimens.sizeSmall,
      padding: EdgeInsets.symmetric(horizontal: context.dimens.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.onSurface.withValues(alpha: context.opacities.medium),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(36),
      ),
      alignment: Alignment.center,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SensorType>(
          value: sensor,
          isDense: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.colors.onSurface,
            size: 16,
          ),
          dropdownColor: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          style: context.textStyle.labelSmall?.copyWith(
            color: context.colors.onSurface,
          ),
          alignment: Alignment.center,
          items: sensor.sensorsGroup.map((sensor) {
            return DropdownMenuItem<SensorType>(
              value: sensor,
              child: Text("${sensor.maxValue} ${sensor.unit.getName(context.strings)}"),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) onSensorClick(newValue);
          },
        ),
      ),
    );
  }
}
