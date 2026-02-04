import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFFDD86);
  static const Color primaryLight = Color(0xFFF5F5EC);
  static const Color secondary = Color(0xFFFDB022);
  static const Color text = Color(0xFF002A52);
  static const Color green = Color(0xFF0B7A75);
  static const Color red = Color(0xFFB3261E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF212529);

  /// Screen background (light cream)
  static const Color surfaceLight = Color(0xFFF8F6F1);
  /// Text field fill and borders
  static const Color textFieldFill = Color(0xFFF0EEEA);
  static const Color textFieldBorder = Color(0xFFE0DDD8);
  static const Color hint = Color(0xFF9E9B96);
  static const Color link = Color(0xFF5A5752);

  // Color scheme for light theme (kept compatible with Material 3)
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: black,
    tertiary: green,
    onTertiary: white,
    error: red,
    onError: white,
    surface: white,
    onSurface: text,
    surfaceContainerHighest: Color(0xFFF1FEFD),
    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),
    shadow: black,
    scrim: black,
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFD0BCFF),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF6750A4),
    onPrimary: Color(0xFF381E72),
    secondary: secondary,
    onSecondary: black,
    tertiary: green,
    onTertiary: white,
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
    surface: Color(0xFF1C1B1F),
    onSurface: Color(0xFFE6E1E5),
    surfaceContainerHighest: Color(0xFF49454F),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
    shadow: black,
    scrim: black,
    inverseSurface: Color(0xFFE6E1E5),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: primary,
  );
}
