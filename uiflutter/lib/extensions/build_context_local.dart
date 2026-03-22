import 'package:flutter/material.dart';
import 'package:uiflutter/extensions/theme_dimensions.dart';
import 'package:uiflutter/extensions/theme_opacities.dart';
import 'package:uiflutter/l10n/app_localizations.dart';

extension BuildContextLocal on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
  ThemeData get themes => Theme.of(this);
  ColorScheme get colors => ColorScheme.of(this);
  ThemeDimensions get dimens => Theme.of(this).extension<ThemeDimensions>()!;
  ThemeOpacities get opacities => Theme.of(this).extension<ThemeOpacities>()!;
}
