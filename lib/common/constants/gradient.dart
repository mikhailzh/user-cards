import 'package:flutter/cupertino.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
abstract class AppGradient {
  static const main = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      Color(0xff9E45ED),
      Color(0xffED44D6),
      Color(0xffF74387),
      Color(0xffFFA373),
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );
  static const second = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[
      Color(0xffE94057),
      Color(0xffFE8068),
    ], // Gradient from https://learnui.design/tools/gradient-generator.html
    tileMode: TileMode.mirror,
  );
}