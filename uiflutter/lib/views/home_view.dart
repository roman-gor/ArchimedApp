import 'package:flutter/material.dart';
import 'package:uiflutter/l10n/app_localizations.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundImage = isDark
        ? 'assets/images/bg_dark.png'
        : 'assets/images/bg_light.png';

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                      AppLocalizations.of(context)!.app_name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
