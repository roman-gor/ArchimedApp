import 'package:flutter/cupertino.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/widgets/experiment_widgets/sensor_button_widget.dart';

import '../../states/bluetooth/sensor_types.dart';

class SensorsBlockWidget extends StatelessWidget {
  const SensorsBlockWidget({
    super.key,
    required this.sensors,
    required this.selectedSensor,
    required this.onSensorClick
  });
  
  final List<SensorType> sensors;
  final SensorType selectedSensor;
  final void Function(SensorType) onSensorClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: context.dimens.paddingMedium),
        itemBuilder: (context, int index) {
          return SensorButtonWidget(
            isSelected: sensors[index] == selectedSensor,
            sensor: sensors[index],
            onSensorClick: (sensor) {
              onSensorClick(sensor);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: context.dimens.paddingMedium);
        },
        itemCount: sensors.length,
      ),
    );
  }
}
