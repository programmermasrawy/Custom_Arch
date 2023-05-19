import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final outline = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  static final ThemeData light = ThemeData(
      // fontFamily: GoogleFonts.cairo().fontFamily,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      // primaryColorBrightness: Brightness.light,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primary,
        secondary: AppColors.pumpkinorange,
      ),
      inputDecorationTheme: outline);

  static final ThemeData dark = ThemeData(
    // fontFamily: GoogleFonts.cairo().fontFamily,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    // primaryColorBrightness: Brightness.dark,
    colorScheme: const ColorScheme.dark().copyWith(secondary: AppColors.accent),
  );
}
