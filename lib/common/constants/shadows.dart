import 'package:flutter/material.dart';

import 'colors.dart';

abstract class Shadows {

  static elevation4({Color firstColor = AppColors.shadowColor}) => [
        BoxShadow(
          color: firstColor,
          blurRadius: 4,
          offset: const Offset(0, 4),
        ),
      ];
}
