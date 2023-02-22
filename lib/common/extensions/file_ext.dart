import 'dart:io';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
extension FileName on File {
  String get name => path.split('/').last;
}
