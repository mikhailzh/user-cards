import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;
import 'package:injectable/injectable.dart';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
abstract class AppEnvironment {
  static const bool IS_RELEASE = foundation.kReleaseMode;

  static const bool IS_DEBUG = !foundation.kReleaseMode;

  static final bool IS_TEST = Platform.environment.containsKey('FLUTTER_TEST');

  static const key = 'env';
  static const mock = 'mock';

  static const mocks = [mock];
  static const real = [
    Environment.prod,
    Environment.dev,
    Environment.test,
  ];
  static const debug = [
    mock,
    Environment.dev,
    Environment.test,
  ];
  static const release = [
    Environment.prod,
  ];
}
