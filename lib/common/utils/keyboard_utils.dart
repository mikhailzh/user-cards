import 'package:flutter/material.dart';

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
