import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
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
          color: context.colors.surface,
        ),
        child: Column(
          spacing: 0,
          children: [
            IconTransparentButtonWidget(
                color: context.colors.onSurface,
                icon: Icons.format_list_bulleted_rounded,
                onPressed: () {}),
            IconTransparentButtonWidget(
                color: context.colors.primary,
                icon: Icons.local_drink_rounded,
                onPressed: () {}),
            IconTransparentButtonWidget(
                color: context.colors.primary,
                icon: Icons.book_rounded,
                onPressed: () {}),
            IconTransparentButtonWidget(
                color: context.colors.primary,
                icon: Icons.list_alt_outlined,
                onPressed: () {}),
            Expanded(child: SizedBox()),
            IconTransparentButtonWidget(
                color: context.colors.primary,
                icon: Icons.settings_rounded,
                onPressed: () {})
          ],
        )
    );
  }
}
