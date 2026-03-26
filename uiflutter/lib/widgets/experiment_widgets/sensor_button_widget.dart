import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/extensions/sensor_type_extensions.dart';

import '../../states/bluetooth/sensor_types.dart';

class SensorButtonWidget extends StatelessWidget {
  const SensorButtonWidget({
    super.key,
    required this.isSelected,
    required this.sensor,
    required this.onSensorClick,
  });

  final bool isSelected;
  final SensorType sensor;
  final void Function(SensorType) onSensorClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 120,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.tertiary,
          border: Border.all(
            color: isSelected ? context.colors.primary : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(36),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onSensorClick(sensor);
            },
            borderRadius: BorderRadius.circular(36),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.dimens.paddingMedium,
              ),
              child: Row(
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
                  Flexible(
                    child: Text(
                      sensor.getName(context),
                      style: TextStyle(
                        color: context.colors.onSurface,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
