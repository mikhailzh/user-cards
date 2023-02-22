import 'package:flutter/material.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
class AppTypography {
  static const light = TextTheme(
    headline3: TextStyle(
      fontSize: 48,
      height: 1.33,
    ),
    headline5: TextStyle(
      fontSize: 24,
      height: 1.33,
    ),
    headline6: TextStyle(
      fontSize: 20,
      height: 1.40,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle2: TextStyle(
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    button: TextStyle(
      fontSize: 14,
      height: 1.71,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
      letterSpacing: 4 / 9,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
    ),
    caption: TextStyle(
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    overline: TextStyle(
      fontSize: 10,
      height: 1.6,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5,
    ),
  );

  static final dark = light.copyWith();
}

enum AppTextStyle {
  headline3,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  button,
  bodyText1,
  bodyText2,
  caption,
  overline,
}

extension AppTextStyleBuilder on AppTextStyle {
  TextStyle? textStyle(TextTheme theme) {
    switch (this) {
      case AppTextStyle.headline3:
        return theme.headline3;
      case AppTextStyle.headline5:
        return theme.headline5;
      case AppTextStyle.headline6:
        return theme.headline6;
      case AppTextStyle.subtitle1:
        return theme.subtitle1;
      case AppTextStyle.subtitle2:
        return theme.subtitle2;
      case AppTextStyle.button:
        return theme.button;
      case AppTextStyle.bodyText1:
        return theme.bodyText1;
      case AppTextStyle.bodyText2:
        return theme.bodyText2;
      case AppTextStyle.caption:
        return theme.caption;
      case AppTextStyle.overline:
        return theme.overline;
    }
  }
}
