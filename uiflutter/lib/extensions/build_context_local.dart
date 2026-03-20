import 'package:flutter/material.dart';
import 'package:uiflutter/l10n/app_localizations.dart';

extension BuildContextLocal on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
  ThemeData get themes => Theme.of(this);
  ColorScheme get colors => ColorScheme.of(this);
}
