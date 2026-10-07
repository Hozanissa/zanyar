// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const teal = Color(0xFF1F4E4C);
  static const terracotta = Color(0xFFC4704B);

  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: teal,
      secondary: terracotta,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: teal,
      secondary: terracotta,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
