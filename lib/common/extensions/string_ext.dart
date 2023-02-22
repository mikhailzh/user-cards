import 'dart:math';

import 'package:intl/intl.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
extension StringFormat on String {
  String get digits => replaceAll(RegExp('[^0-9]'), '');

  bool get isNotBlank => trim().isNotEmpty;

  String? get ifNotEmpty => isNotBlank ? trim() : null;
}

extension StringDate on String {
  DateTime get dateTime => DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZ").parse(this);

  String get showDate => dateTime.showDate;
}

extension DateString on DateTime {
  String get apiDate => DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZ").format(this);

  String get showDate => DateFormat("dd.MM.yyyy HH:mm:ss").format(this);
}

extension PriceString on int {
  String get stringPrice => NumberFormat.currency(locale: "en_US", symbol: "₽").format(this);
}

extension StringExt on String {
  List<String> changeWay(String to) {
    if (this == to) return [this];
    final values = List.generate(length + 1, (i) => List.generate(to.length + 1, (j) => _value(i, j)));
    for (final i in range(from: 1, to: values.length)) {
      for (final j in range(from: 1, to: values[0].length)) {
        values[i][j] = min(
          values[i - 1][j] + 1,
          min(
            values[i][j - 1] + 1,
            values[i - 1][j - 1] + (codeUnitAt(i - 1) == to.codeUnitAt(j - 1) ? 0 : 1),
          ),
        );
      }
    }
    return _generateWay(this, to, values);
  }

  List<String> _generateWay(String s1, String s2, List<List<int>> values) {
    int i = s1.length;
    int j = s2.length;
    final result = <String>[];
    var currStr = s2;
    result.insert(0, s2);
    while (i > 0 && j > 0) {
      if (values[i][j] - values[i][j - 1] == 1) {
        // insert in j
        if (j + 1 < currStr.length) {
          currStr = currStr.substring(0, j) + currStr.substring(j + 1);
        } else {
          currStr = currStr.substring(0, j);
        }
        j--;
        result.insert(0, currStr);
      } else if (values[i][j] - values[i - 1][j] == 1) {
        // remove in i
        if (j < currStr.length) {
          currStr = currStr.substring(0, j) + s1.substring(i - 1, i) + currStr.substring(j);
        } else {
          currStr = currStr.substring(0, j) + s1.substring(i - 1, i);
        }
        i--;
        result.insert(0, currStr);
      } else {
        if (values[i][j] != values[i - 1][j - 1]) {
          if (j < currStr.length) {
            currStr = currStr.substring(0, j) + s1.substring(i - 1, i) + currStr.substring(j);
          } else {
            currStr = currStr.substring(0, j) + s1.substring(i - 1, i);
          }
          result.insert(0, currStr);
        }
        i--;
        j--;
      }
    }
    while (i > 0) {
      // remove in i
      if (j < currStr.length) {
        currStr = currStr.substring(0, j) + s1.substring(i - 1, i) + currStr.substring(j);
      } else {
        currStr = currStr.substring(0, j) + s1.substring(i - 1, i);
      }
      result.insert(0, currStr);
      i--;
    }
    while (j > 0) {
      // insert in j
      if (j + 1 < currStr.length) {
        currStr = currStr.substring(0, j) + currStr.substring(j + 1);
      } else {
        currStr = currStr.substring(0, j);
      }
      result.insert(0, currStr);
      j--;
    }
    result.insert(0, s1);
    return result;
  }
}

int _value(int i, int j) {
  if (i == 0 || j == 0) return max(i, j);
  return 0;
}

List<int> range({int from = 0, required int to}) => List.generate(to - from, (index) => index + from);
