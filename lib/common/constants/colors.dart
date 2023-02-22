import 'package:flutter/material.dart';

/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
class AppColors {
  static const light = ColorScheme.light(
    primary: Color(0xFFF44336),
    primaryVariant: Color(0xFFEF5350),
    secondary: Color(0xFF1976D2),
    secondaryVariant: Color(0xFF2196F3),
    surface: Color(0xFFFFFFFF),
    background: Color(0xFFF5F5F5),
    error: Color(0xFFE6312D),
    onPrimary: Color(0xFF002334),
    onSecondary: Color(0xFF002334),
    onSurface: Color(0xFF002334),
    onBackground: Color(0xFF002334),
    onError: Color(0xFFFFFFFF),
  );

  static const dark = ColorScheme.dark(
    primary: Color(0xFF1976D2),
    primaryVariant: Color(0xFF2196F3),
    secondary: Color(0xFFFBC02D),
    secondaryVariant: Color(0xFFFFEB3B),
    surface: Color(0xFF121212),
    background: Color(0xFF121212),
    error: Color(0xFFCF6679),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFFFFFFFF),
    onBackground: Color(0xFFFFFFFF),
    onError: Color(0xFF000000),
  );

  static const shadowColor = Color(0x40000000);
}
