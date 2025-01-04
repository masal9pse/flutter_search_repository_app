import 'package:flutter/material.dart';
import 'dart:ui';

class TextStyleExtension extends ThemeExtension<TextStyleExtension> {
  const TextStyleExtension({
    this.color,
    this.fontSize,
  });

  final Color? color;
  final double? fontSize;

  @override
  ThemeExtension<TextStyleExtension> copyWith({
    Color? color,
    double? fontSize,
  }) =>
      TextStyleExtension(
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
      );

  @override
  ThemeExtension<TextStyleExtension> lerp(
      ThemeExtension<TextStyleExtension>? other, double t) {
    if (other is! TextStyleExtension) {
      return this;
    }

    return TextStyleExtension(
      color: Color.lerp(color, other.color, t),
      fontSize: lerpDouble(fontSize, other.fontSize, t),
    );
  }
}
