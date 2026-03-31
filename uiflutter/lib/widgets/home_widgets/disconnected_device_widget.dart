import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class DisconnectedDeviceWidget extends StatelessWidget {
  const DisconnectedDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: context.dimens.paddingMedium,
      children: [
        Icon(
          Icons.bluetooth_disabled,
          color: context.colors.onTertiary,
          size: context.dimens.sizeExtraSmall,
        ),
        Text(
          context.strings.not_connected,
          style: context.textStyle.titleMedium?.copyWith(
            color: context.colors.onSurface,
          ),
        ),
        const SizedBox(width: 1,)
      ],
    );
  }
}
