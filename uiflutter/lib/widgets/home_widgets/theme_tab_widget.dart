import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/build_context_local.dart';

import '../../data/theme_cubit.dart';

class ThemeTabWidget extends StatelessWidget {
  const ThemeTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isSystemDark =
            MediaQuery.platformBrightnessOf(context) == Brightness.dark;

        final isCurrentlyDark =
            themeMode == ThemeMode.dark ||
            (themeMode == ThemeMode.system && isSystemDark);

        return Container(
          padding: EdgeInsets.all(context.dimens.paddingLarge),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.dimens.borderRadius),
            color: context.colors.surface,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              spacing: context.dimens.paddingMedium,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    context.strings.theme,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.surfaceContainer,
                  ),
                  child: Icon(
                    isCurrentlyDark
                        ? Icons.nightlight_round
                        : Icons.wb_sunny_rounded,
                    size: 70,
                    color: isCurrentlyDark
                        ? Colors.amber.shade200
                        : Colors.orange,
                  ),
                ),
                SizedBox(
                  height: 42,
                  width: 76,
                  child: Switch(
                    value: isCurrentlyDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                        Set<WidgetState> states,
                        ) {
                      if (states.contains(WidgetState.selected)) {
                        return const Icon(
                          Icons.nightlight_round,
                          color: Colors.indigo,
                        );
                      }
                      return const Icon(
                        Icons.wb_sunny_rounded,
                        color: Colors.orange,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
