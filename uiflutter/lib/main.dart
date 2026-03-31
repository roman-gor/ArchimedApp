import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiflutter/extensions/theme_dimensions.dart';
import 'package:uiflutter/extensions/theme_opacities.dart';
import 'package:uiflutter/views/home_view.dart';
import 'data/theme_cubit.dart';
import 'l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(const ArchimedApplication());
}

class ArchimedApplication extends StatelessWidget {
  const ArchimedApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'INTLab',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: HomeView(),
          );
        },
      ),
    );
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF0b74da),
    surface: Colors.white,
    onSurface: Colors.black,
    secondary: Colors.white,
    tertiary: Color(0xFFF3F9FF),
    onTertiary: Color(0xFF0b74da),
    surfaceContainer: Color(0xFF81D4FA),
    secondaryContainer: Color(0xFF222222),
  ),
  extensions: const [
    ThemeDimensions(
      paddingSmall: 4.0,
      paddingMedium: 8.0,
      paddingLarge: 16.0,
      paddingExtraLarge: 24.0,
      borderRadius: 16.0,
    ),
    ThemeOpacities(high: 0.7, medium: 0.5, low: 0.2),
  ],
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF0b74da),
    surface: Color(0xFF0B0D32),
    onSurface: Colors.white,
    secondary: Color(0xFF10274E),
    tertiary: Color(0xFF0B0D32),
    onTertiary: Colors.white,
    surfaceContainer: Color(0xFF1A237E),
    secondaryContainer: Color(0xFFFFFFFF),
  ),
  extensions: const [
    ThemeDimensions(
      paddingSmall: 4.0,
      paddingMedium: 8.0,
      paddingLarge: 16.0,
      paddingExtraLarge: 24.0,
      borderRadius: 16.0,
    ),
    ThemeOpacities(high: 0.7, medium: 0.5, low: 0.2),
  ],
);
