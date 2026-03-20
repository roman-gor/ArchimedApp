import 'package:flutter/material.dart';

class IconTransparentButtonWidget extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final VoidCallback? onPressed;

  const IconTransparentButtonWidget({
    super.key,
    this.color,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(icon),
      color: color,
      iconSize: 26,
      onPressed: onPressed,
    );
  }
}
