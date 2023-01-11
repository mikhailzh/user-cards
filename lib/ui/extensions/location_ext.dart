import 'package:location/location.dart';
import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/common/extensions/location_ext.dart';
import 'package:user_cards/domain/models/location.dart' as model;

extension LocationExt on model.Location {
  String textWithDistance(LocationData? locationData) {
    if (locationData != null) {
      final distance = locationData.distanceFrom(this);
      return Strings.location.nameWithDistance(name, distance);
    }
    return name;
  }
}