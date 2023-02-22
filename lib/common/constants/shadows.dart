import 'package:flutter/material.dart';

import 'colors.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
abstract class Shadows {

  static elevation4({Color firstColor = AppColors.shadowColor}) => [
        BoxShadow(
          color: firstColor,
          blurRadius: 4,
          offset: const Offset(0, 4),
        ),
      ];
}
