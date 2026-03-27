import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/widgets/home_widgets/uncolored_button_widget.dart';

import 'colored_button_widget.dart';

class DefaultDialogWidget extends StatelessWidget {
  const DefaultDialogWidget({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.text,
    required this.dismissText,
    required this.confirmText,
    this.onDismiss,
    this.onConfirm
  });

  final IconData icon;
  final Color bgColor;
  final String text;
  final String dismissText;
  final String confirmText;
  final VoidCallback? onDismiss;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.secondary,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: EdgeInsets.all(context.dimens.paddingExtraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(context.dimens.paddingLarge),
                  decoration: BoxDecoration(
                    color: bgColor.withValues(alpha: context.opacities.low),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: context.dimens.sizeSmall,
                    color: bgColor,
                  ),
                ),
                SizedBox(width: context.dimens.paddingLarge),
                Expanded(
                  child: Text(
                    text,
                    style: context.textStyle.titleMedium?.copyWith(
                      color: context.colors.onSurface,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: context.dimens.paddingLarge,
              children: [
                UncoloredButtonWidget(
                  text: dismissText,
                  onPressed: onDismiss,
                ),
                ColoredButtonWidget(
                  text: confirmText,
                  onPressed: onConfirm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
