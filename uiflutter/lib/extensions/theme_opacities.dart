import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeOpacities extends ThemeExtension<ThemeOpacities> {
  const ThemeOpacities({
    required this.high,
    required this.medium,
    required this.low
  });

  final double high;
  final double medium;
  final double low;

  @override
  ThemeExtension<ThemeOpacities> copyWith({
    double? high,
    double? medium,
    double? low
  }) {
    return ThemeOpacities(
      high: high ?? this.high,
      medium: medium ?? this.medium,
      low: low ?? this.low,
    );
  }

  @override
  ThemeExtension<ThemeOpacities> lerp(
      covariant ThemeExtension<ThemeOpacities>? other,
      double t
      ) {
    if (other is! ThemeOpacities) return this;
    return ThemeOpacities(
      high: lerpDouble(high, other.high, t) ?? high,
      medium: lerpDouble(medium, other.medium, t) ?? medium,
      low: lerpDouble(low, other.low, t) ?? low,
    );
  }

}
