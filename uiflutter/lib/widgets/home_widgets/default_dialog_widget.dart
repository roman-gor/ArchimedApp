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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor.withAlpha(30),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: bgColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: context.colors.onSurface,
                      fontSize: 16,
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
              spacing: 16,
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
