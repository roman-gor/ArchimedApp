import 'package:flutter/material.dart';

import '../../extensions/build_context_local.dart';

class CapsuleSelectWidget extends StatelessWidget{
  const CapsuleSelectWidget({
    super.key,
    required this.onElementClick, 
    required this.selectedValue,
    required this.elementsList
  });
  
  final void Function(int) onElementClick;
  final int selectedValue;
  final List<int> elementsList;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.dimens.paddingSmall),
        decoration: BoxDecoration(
            color: context.colors.tertiaryContainer,
            borderRadius: BorderRadius.circular(36)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<int>(
                style: SegmentedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  selectedBackgroundColor: isDark
                      ? context.colors.onPrimary.withValues(alpha: context.opacities.high)
                      : context.colors.onPrimary.withValues(alpha: context.opacities.low),
                  foregroundColor: context.colors.onTertiary,
                  selectedForegroundColor: context.colors.onTertiary,
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                segments: elementsList.map((element) => ButtonSegment<int>(
                  value: element,
                  label: Text(
                    element.toString(), style: const TextStyle(fontSize: 14)),
                )).toList(),
                selected: { selectedValue },
                onSelectionChanged: (elements) => onElementClick(elements.first),
                showSelectedIcon: false,
              )
            ]
        )
    );
  }
}
