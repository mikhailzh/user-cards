
import 'dart:math';

extension ListExt<T> on List<T> {
  T random([Random? from]) => this[(from ?? Random()).nextInt(length)];
}