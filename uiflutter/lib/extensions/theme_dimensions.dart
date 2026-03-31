import 'package:flutter/material.dart';
import 'dart:ui';

class ThemeDimensions extends ThemeExtension<ThemeDimensions> {
  const ThemeDimensions({
    required this.paddingSmall,
    required this.paddingMedium,
    required this.paddingLarge,
    required this.paddingExtraLarge,
    required this.borderRadius
  });

  final double paddingSmall;
  final double paddingMedium;
  final double paddingLarge;
  final double paddingExtraLarge;
  final double borderRadius;

  @override
  ThemeExtension<ThemeDimensions> copyWith({
    double? paddingSmall,
    double? paddingMedium,
    double? paddingLarge,
    double? paddingExtraLarge,
    double? borderRadius
  }) {
    return ThemeDimensions(
      paddingSmall: paddingSmall ?? this.paddingSmall,
      paddingMedium: paddingMedium ?? this.paddingMedium,
      paddingLarge: paddingLarge ?? this.paddingLarge,
      paddingExtraLarge: paddingExtraLarge ?? this.paddingExtraLarge,
      borderRadius: borderRadius ?? this.borderRadius
    );
  }

  @override
  ThemeExtension<ThemeDimensions> lerp(
      covariant ThemeExtension<ThemeDimensions>? other,
      double t,
      ) {
    if (other is! ThemeDimensions) return this;
    return ThemeDimensions(
      paddingSmall: lerpDouble(paddingSmall, other.paddingSmall, t) ?? paddingSmall,
      paddingMedium: lerpDouble(paddingMedium, other.paddingMedium, t) ?? paddingMedium,
      paddingLarge: lerpDouble(paddingLarge, other.paddingLarge, t) ?? paddingLarge,
      paddingExtraLarge: lerpDouble(paddingExtraLarge, other.paddingExtraLarge, t) ?? paddingExtraLarge,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius
    );
  }
}
