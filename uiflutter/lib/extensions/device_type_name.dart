import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';

import '../states/bluetooth/sensor_types.dart';

extension DeviceTypeName on DeviceType {
  String getName(BuildContext context) {
    switch(this) {
      case DeviceType.ecology: return context.strings.ecology;
      case DeviceType.physics: return context.strings.physics;
      case DeviceType.biology: return context.strings.biology;
      case DeviceType.physiology: return context.strings.physiology;
      case DeviceType.unknown: return context.strings.unknown;
    }
  }
}
