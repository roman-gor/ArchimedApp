import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class DisconnectedDeviceWidget extends StatelessWidget {
  const DisconnectedDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          Icons.bluetooth_disabled,
          color: context.colors.onTertiary,
          size: 24,
        ),
        Text(
          context.strings.not_connected,
          style: TextStyle(
            color: context.colors.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
  
}
