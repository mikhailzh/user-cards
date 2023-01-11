import 'package:flutter/material.dart';
import 'package:user_cards/common/constants/colors.dart';
import 'package:user_cards/common/constants/type.dart';

class AppTheme {
  static final light = ThemeData.from(
    colorScheme: AppColors.light,
    textTheme: AppTypography.light,
  );

  static final dark = ThemeData.from(
    colorScheme: AppColors.dark,
    textTheme: AppTypography.dark,
  );
}
