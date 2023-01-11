import 'package:flutter/material.dart';

extension CopyWith on TextStyle {
  TextStyle? copyWithOpacity(double opacity) => copyWith(color: color?.withOpacity(opacity));
}
