import 'dart:math';

import 'package:location/location.dart';
import 'package:user_cards/domain/models/location.dart' as model;

extension LocationDataExt on LocationData {
  int distanceFrom(model.Location location) {
    const R = 6371e3; // metres
    final fi1 = (latitude ?? 0) * pi / 180; // φ, λ in radians
    final fi2 = location.latitude * pi / 180;
    final deltaFi = (location.latitude - (latitude ?? 0)) * pi / 180;
    final deltaLambda = (location.longitude - (longitude ?? 0)) * pi / 180;

    final a = sin(deltaFi / 2) * sin(deltaFi / 2) +
        cos(fi1) * cos(fi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final d = R * c; // in metres

    return d ~/ 1000;
  }
}
