import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class LoadingConnectionWidget extends StatelessWidget {
  const LoadingConnectionWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.dimens.paddingMedium,
      children: [
        Text(
          title,
          style: context.textStyle.bodyMedium?.copyWith(
            color: context.colors.onSurface.withValues(
              alpha: context.opacities.high,
            ),
          ),
        ),
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: context.colors.onSurface,
            strokeWidth: 2,
          ),
        ),
      ],
    );
  }
}
