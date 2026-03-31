import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/build_context_local.dart';
import 'package:uiflutter/extensions/theme_dimensions.dart';
import 'package:uiflutter/extensions/theme_opacities.dart';
import 'package:uiflutter/views/home_view.dart';
import 'cubits/theme_cubit.dart';
import 'l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'navigation/navigator_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const ArchimedApplication());
}

class ArchimedApplication extends StatelessWidget {
  const ArchimedApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'INTLab',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigatorLocal.navigatorKey,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: getLightColorScheme(),
              extensions: getExtensions(isMobile),
              textTheme: getTextStyles(isMobile),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: getDarkColorScheme(),
              extensions: getExtensions(isMobile),
              textTheme: getTextStyles(isMobile),
            ),
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeView(),
          );
        },
      ),
    );
  }

  TextTheme getTextStyles(bool isMobile) {
    return isMobile
        ? const TextTheme(
            bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400), 
            bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            labelSmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)
          )
        : const TextTheme(
            bodySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            labelSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
          );
  }

  ColorScheme getDarkColorScheme() {
    return ColorScheme.dark(
      primary: Color(0xFF0b74da),
      surface: Color(0xFF0B0D32),
      onSurface: Colors.white,
      secondary: Color(0xFF10274E),
      tertiary: Color(0xFF0B0D32),
      onTertiary: Colors.white,
      primaryContainer: Color(0xFF34628F),
      onPrimary: Color(0xFF34628F),
      surfaceContainer: Color(0xFF1A237E),
      secondaryContainer: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFFFFCFC),
      tertiaryContainer: Color(0xFF0B0D32),
    );
  }

  ColorScheme getLightColorScheme() {
    return ColorScheme.light(
      primary: Color(0xFF0b74da),
      surface: Colors.white,
      onSurface: Colors.black,
      secondary: Colors.white,
      tertiary: Color(0xFFF3F9FF),
      onTertiary: Color(0xFF0b74da),
      primaryContainer: Color(0xFF99CCFF),
      onPrimary: Color(0xFF0b74da),
      surfaceContainer: Color(0xFF81D4FA),
      secondaryContainer: Color(0xFF222222),
      onSecondaryContainer: Color(0xFF9A9A9A),
      tertiaryContainer: Color(0xFFF3F9FF),
    );
  }

  List<ThemeExtension<dynamic>> getExtensions(bool isMobile) {
    return isMobile
        ? const [
            ThemeDimensions(
              paddingSmall: 4.0,
              paddingMedium: 8.0,
              paddingLarge: 16.0,
              paddingExtraLarge: 24.0,
              borderRadius: 16.0,
              sizeExtraSmall: 24,
              sizeSmall: 30,
              sizeMedium: 40,
              sizeLarge: 44,
            ),
            ThemeOpacities(high: 0.7, medium: 0.5, low: 0.2),
          ]
        : const [
            ThemeDimensions(
              paddingSmall: 4.0,
              paddingMedium: 8.0,
              paddingLarge: 16.0,
              paddingExtraLarge: 24.0,
              borderRadius: 16.0,
              sizeExtraSmall: 32,
              sizeSmall: 42,
              sizeMedium: 52,
              sizeLarge: 68,
            ),
            ThemeOpacities(high: 0.7, medium: 0.5, low: 0.2),
          ];
  }
}
