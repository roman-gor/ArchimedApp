import 'package:flutter/material.dart';

import '../../cubits/home_tabs_cubit.dart';
import '../../extensions/build_context_local.dart';

class TabButtonWidget extends StatelessWidget {
  const TabButtonWidget({
    super.key, 
    required this.tab, 
    required this.onTabClick, 
    required this.isSelected
  });

  final HomeTabs tab;
  final void Function(HomeTabs) onTabClick;
  final bool isSelected;
  
  @override
  Widget build(BuildContext context) {
    final decorationColor = isSelected
        ? context.colors.primary.withValues(alpha: context.opacities.low)
        : Colors.transparent;

    return InkWell(
      onTap: () => onTabClick(tab),
      child: Container(
        padding: EdgeInsets.all(context.dimens.paddingMedium),
        decoration: BoxDecoration(
          color: decorationColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          tab.icon,
          color: context.colors.primary,
          size: context.dimens.sizeSmall,
        ),
      ),
    );
  }
  
}
