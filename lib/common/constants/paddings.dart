import 'package:flutter/material.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
enum Paddings {
  zero,
  extraTiny,
  tiny,
  five,
  seven,
  extraSmall,
  ten,
  small,
  normal,
  twenty,
  secondaryNormal,
  large,
  secondaryLarge,
  extraLarge,
}

extension PaddingsValue on Paddings {
  double get value {
    switch (this) {
      case Paddings.zero:
        return 0.0;
      case Paddings.extraTiny:
        return 2.0;
      case Paddings.tiny:
        return 4.0;
      case Paddings.five:
        return 5.0;
      case Paddings.seven:
        return 7.0;
      case Paddings.extraSmall:
        return 8.0;
      case Paddings.ten:
        return 10.0;
      case Paddings.small:
        return 12.0;
      case Paddings.normal:
        return 16.0;
      case Paddings.twenty:
        return 20.0;
      case Paddings.secondaryNormal:
        return 24.0;
      case Paddings.large:
        return 32.0;
      case Paddings.secondaryLarge:
        return 48.0;
      case Paddings.extraLarge:
        return 64.0;
    }
  }
}

extension PaddingsWidgets on Paddings {
  Widget spacer() {
    return SizedBox.fromSize(size: Size.square(value));
  }

  Widget expanded({int flex = 1}) {
    return Expanded(
      child: spacer(),
      flex: flex,
    );
  }
}
