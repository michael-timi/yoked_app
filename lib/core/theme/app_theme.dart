import 'package:flutter/material.dart';
import 'app_colors.dart';
import '../constants/app_fonts.dart';

class AppTheme {
  static const String _fontFamily = AppFonts.hellix;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      fontFamily: _fontFamily,
      textTheme: _textTheme(ThemeData.light().textTheme),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      fontFamily: _fontFamily,
      textTheme: _textTheme(ThemeData.dark().textTheme),
    );
  }

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontFamily: _fontFamily),
      displayMedium: base.displayMedium?.copyWith(fontFamily: _fontFamily),
      displaySmall: base.displaySmall?.copyWith(fontFamily: _fontFamily),
      headlineLarge: base.headlineLarge?.copyWith(fontFamily: _fontFamily),
      headlineMedium: base.headlineMedium?.copyWith(fontFamily: _fontFamily),
      headlineSmall: base.headlineSmall?.copyWith(fontFamily: _fontFamily),
      titleLarge: base.titleLarge?.copyWith(fontFamily: _fontFamily),
      titleMedium: base.titleMedium?.copyWith(fontFamily: _fontFamily),
      titleSmall: base.titleSmall?.copyWith(fontFamily: _fontFamily),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: _fontFamily),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: _fontFamily),
      bodySmall: base.bodySmall?.copyWith(fontFamily: _fontFamily),
      labelLarge: base.labelLarge?.copyWith(fontFamily: _fontFamily),
      labelMedium: base.labelMedium?.copyWith(fontFamily: _fontFamily),
      labelSmall: base.labelSmall?.copyWith(fontFamily: _fontFamily),
    );
  }
}
