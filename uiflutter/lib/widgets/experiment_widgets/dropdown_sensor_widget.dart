import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../extensions/build_context_local.dart';
import '../../extensions/measures_unit_extensions.dart';
import '../../extensions/sensor_type_extensions.dart';
import '../../states/bluetooth/sensor_types.dart';

class DropdownSensorWidget extends StatelessWidget {
  const DropdownSensorWidget({
    super.key,
    required this.sensor,
    required this.onSensorClick,
    required this.isSelected,
    required this.needDropdown,
    this.expandedValues = const [],
  });

  final SensorType sensor;
  final void Function(SensorType) onSensorClick;
  final bool isSelected;
  final bool needDropdown;
  final List<int> expandedValues;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? context.colors.primaryContainer
        : context.colors.tertiary;

    return SizedBox(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(36),
        ),
        child: InkWell(
          onTap: () => onSensorClick(sensor),
          borderRadius: BorderRadius.circular(36),
          child: _sensorButtonContent(
            context: context,
            sensor: sensor,
            needDropdown: needDropdown,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _sensorButtonContent({
    required BuildContext context,
    required SensorType sensor,
    required bool needDropdown,
    required Color backgroundColor,
  }) {
    final padding = needDropdown
        ? EdgeInsets.only(left: context.dimens.paddingMedium)
        : EdgeInsets.symmetric(horizontal: context.dimens.paddingMedium);
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 2),
          SvgPicture.asset(
            sensor.imagePath,
            fit: BoxFit.contain,
            width: 24,
            height: 24,
          ),
          SizedBox(width: context.dimens.paddingMedium),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 60),
            child: Text(
              sensor.getName(context.strings),
              style: TextStyle(
                color: context.colors.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: context.dimens.paddingMedium),
          if (needDropdown) ...[
            _buildCompactDropdown(context, sensor, backgroundColor)
          ],
          SizedBox(width: context.dimens.paddingSmall),
        ],
      ),
    );
  }

  Widget _buildCompactDropdown(
      BuildContext context, SensorType sensor, Color backgroundColor) {
    return Container(
      height: 30,
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
          style: TextStyle(
            color: context.colors.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w400,
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
