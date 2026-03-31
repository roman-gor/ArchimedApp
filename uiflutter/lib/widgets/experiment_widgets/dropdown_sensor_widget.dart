import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../extensions/build_context_local.dart';
import '../../extensions/sensor_type_extensions.dart';
import '../../states/bluetooth/sensor_types.dart';
import 'dropdown_widget.dart';

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
      height: context.dimens.sizeMedium,
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
            width: context.dimens.sizeExtraSmall,
            height: context.dimens.sizeExtraSmall,
          ),
          SizedBox(width: context.dimens.paddingMedium),
          ConstrainedBox(
            constraints: context.isMobile 
                ? BoxConstraints(maxWidth: 60) 
                : BoxConstraints(),
            child: Text(
              sensor.getName(context.strings),
              style: context.textStyle.bodySmall?.copyWith(
                color: context.colors.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: context.dimens.paddingMedium),
          if (needDropdown) ...[
            DropdownWidget(
              sensor: sensor, 
              backgroundColor: backgroundColor,
              onSensorClick: (newValue) => onSensorClick(newValue),
            )
          ],
          SizedBox(width: context.dimens.paddingSmall),
        ],
      ),
    );
  }
}
