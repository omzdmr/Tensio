import 'package:flutter/material.dart';
import 'package:tensio/core/design/tensio_colors.dart';

abstract final class TensioTheme {
  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: TensioColors.coral,
      brightness: Brightness.dark,
      surface: TensioColors.surface,
    ).copyWith(
      primary: TensioColors.coral,
      secondary: TensioColors.blue,
      tertiary: TensioColors.emerald,
      outline: TensioColors.outline,
    );

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: TensioColors.background,
      textTheme: const TextTheme(
        displaySmall: TextStyle(fontSize: 40, height: 1.10, fontWeight: FontWeight.w700, color: TensioColors.textPrimary),
        headlineMedium: TextStyle(fontSize: 24, height: 1.25, fontWeight: FontWeight.w600, color: TensioColors.textPrimary),
        titleLarge: TextStyle(fontSize: 20, height: 1.30, fontWeight: FontWeight.w600, color: TensioColors.textPrimary),
        bodyLarge: TextStyle(fontSize: 17, height: 1.40, color: TensioColors.textPrimary),
        bodyMedium: TextStyle(fontSize: 15, height: 1.40, color: TensioColors.textSecondary),
        labelLarge: TextStyle(fontSize: 13, height: 1.35, fontWeight: FontWeight.w600, color: TensioColors.textPrimary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: TensioColors.surface,
        indicatorColor: TensioColors.coral.withOpacity(.16),
        labelTextStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TensioColors.surfaceRaised,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: TensioColors.outline)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: TensioColors.outline)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)), borderSide: BorderSide(color: TensioColors.coral, width: 1.5)),
      ),
    );
  }
}
