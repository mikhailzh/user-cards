
import 'dart:math';
/// common - содержит константы, базовые расширения и утилиты, которые не зависят от логики приложения
extension ListExt<T> on List<T> {
  T random([Random? from]) => this[(from ?? Random()).nextInt(length)];
}