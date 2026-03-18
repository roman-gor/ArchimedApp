import 'package:flutter/material.dart';
import 'package:uiflutter/widgets/home_widgets/icon_transparent_button_widget.dart';

class ToolsBlock extends StatelessWidget {
  const ToolsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          spacing: 0,
          children: [
            IconTransparentButton(
                color: Theme.of(context).colorScheme.onSurface,
                icon: Icons.format_list_bulleted_rounded,
                onPressed: () {}),
            IconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.local_drink_rounded,
                onPressed: () {}),
            IconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.book_rounded,
                onPressed: () {}),
            IconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.list_alt_outlined,
                onPressed: () {}),
            Expanded(child: SizedBox()),
            IconTransparentButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.settings_rounded,
                onPressed: () {})
          ],
        )
    );
  }
}
