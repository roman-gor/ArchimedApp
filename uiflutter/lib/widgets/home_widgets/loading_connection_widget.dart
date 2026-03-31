import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class LoadingConnectionWidget extends StatelessWidget {
  const LoadingConnectionWidget({super.key, required this.title});
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            color: context.colors.onSurface,
            strokeWidth: 2,
          ),
        ),
        SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(color: context.colors.onSurface, fontSize: 16),
        ),
      ],
    );
  }
}
