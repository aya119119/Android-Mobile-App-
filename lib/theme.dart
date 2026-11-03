import 'package:flutter/material.dart';

/// Colors taken from the Stitch design.
class AppColors {
  static const primary = Color(0xFF532CD8);
  static const purple = Color(0xFF6C4CF1); // main theme color
  static const primaryFixed = Color(0xFFE6DEFF);
  static const yellow = Color(0xFFFDC73A);
  static const yellowShadow = Color(0xFFDFA61E);
  static const onYellow = Color(0xFF6F5400);
  static const surface = Color(0xFFFCF8FF);
  static const card = Color(0xFFF0EBFF);
  static const cardHigh = Color(0xFFEAE5FF);
  static const text = Color(0xFF1A1736);
  static const textSoft = Color(0xFF484555);
  static const outline = Color(0xFF797587);
  static const outlineLight = Color(0xFFC9C4D8);
  static const green = Color(0xFF00602F);
  static const mint = Color(0xFF6DFE9C);
}

TextStyle heading(double size, {Color color = AppColors.text}) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w800,
      color: color,
    );

TextStyle body(double size,
        {Color color = AppColors.textSoft,
        FontWeight weight = FontWeight.w500}) =>
    TextStyle(fontSize: size, fontWeight: weight, color: color);

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.surface,
    colorScheme: const ColorScheme.light(
      primary: AppColors.purple,
      onPrimary: Colors.white,
      secondary: AppColors.yellow,
      onSecondary: AppColors.onYellow,
      surface: AppColors.surface,
      onSurface: AppColors.text,
    ),
  );
}