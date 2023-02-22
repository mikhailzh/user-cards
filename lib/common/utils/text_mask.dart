import 'package:flutter/services.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
class USPhoneFormatter extends TextInputFormatter {
  static String? format(String? value) {
    if (value == null) {
      return null;
    }
    return USPhoneFormatter()
        .formatEditUpdate(
          const TextEditingValue(text: ''),
          TextEditingValue(text: value),
        )
        .text;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 0) + '(');
      if (newValue.selection.end >= 0) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(text: newText.toString(), selection: TextSelection.collapsed(offset: selectionIndex));
  }
}

class TimeFormatter extends TextInputFormatter {
  static String? format(String? value) {
    if (value == null) {
      return null;
    }
    return TimeFormatter()
        .formatEditUpdate(
          const TextEditingValue(text: ''),
          TextEditingValue(text: value),
        )
        .text;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 2) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ':');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(2, usedSubstringIndex = 4) + ':');
      if (newValue.selection.end >= 4) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(text: newText.toString(), selection: TextSelection.collapsed(offset: selectionIndex));
  }
}
