import 'package:flutter/material.dart';
import 'package:uiflutter/data/home_tabs_cubit.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/widgets/home_widgets/tap_button_widget.dart';

class ToolsBlock extends StatelessWidget {
  const ToolsBlock({
    super.key,
    required this.selectedTab,
    required this.onTabClick
  });

  final HomeTabs selectedTab;
  final ValueChanged<HomeTabs> onTabClick;

  @override
  Widget build(BuildContext context) {
    final topTabs = HomeTabs.values.where((tab) => tab != HomeTabs.settings);

    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(context.dimens.paddingMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.dimens.borderRadius),
          color: context.colors.surface,
        ),
        child: Column(
          children: [
            ...topTabs.map((tab) => Padding(
              padding: EdgeInsets.only(bottom: context.dimens.paddingMedium),
              child: TabButtonWidget(
                tab: tab,
                isSelected: selectedTab == tab, 
                onTabClick: (tab) => onTabClick(tab),
              ),
            )),
            const Expanded(child: SizedBox()),
            TabButtonWidget(
              tab: HomeTabs.settings,
              isSelected: selectedTab == HomeTabs.settings,
              onTabClick: (tab) => onTabClick(tab),
            ),
          ],
        )
    );
  }
}
