import 'package:flutter/material.dart';
import 'package:uiflutter/views/home_view.dart';
import 'package:uiflutter/l10n/app_localizations.dart';

void main() => runApp(const ArchimedApplication());

class ArchimedApplication extends StatelessWidget {
  const ArchimedApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'INTLab',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.light(
            primary: Color(0xFF0b74da),
            surface: Colors.white,
            onSurface: Colors.black
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: Color(0xFF0b74da),
            surface: Color(0xFF0B0D32),
            onSurface: Colors.white
          ),
        ),
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeView()
    );
  }
}
