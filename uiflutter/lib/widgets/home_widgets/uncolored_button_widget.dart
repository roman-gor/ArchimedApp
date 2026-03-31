import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class UncoloredButtonWidget extends StatelessWidget {
  const UncoloredButtonWidget({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 150),
      child: SizedBox(
        height: context.dimens.sizeMedium,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colors.tertiary,
            side: BorderSide(
              color: context.colors.primary.withValues(alpha: context.opacities.low),
              width: 1.0,
            ),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: Text(
            text,
            style: context.textStyle.bodyLarge?.copyWith(
              color: context.colors.onTertiary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
