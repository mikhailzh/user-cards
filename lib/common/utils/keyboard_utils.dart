import 'package:flutter/material.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
abstract class KeyboardUtils {
  static void hide() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void next(BuildContext context) {
    final scope = FocusScope.of(context);
    do {
      scope.nextFocus();
    } while (scope.focusedChild?.context?.widget is! EditableText);
  }
}
