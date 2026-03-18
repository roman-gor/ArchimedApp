import 'package:flutter/material.dart';

class UncoloredButtonWidget extends StatelessWidget {
  const UncoloredButtonWidget({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary.withAlpha(70),
            width: 1.0,
          ),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
