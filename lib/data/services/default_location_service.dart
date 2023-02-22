import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:user_cards/domain/services/location_service.dart';
/// data - содержит релизацию абстракций domain и вспомогательные для этого файлы
///
/// service - все что не попадает под описание interactor или repository
@LazySingleton(as: LocationService)
class DefaultLocationService extends LocationService {
  Location location = Location();

  DefaultLocationService() {
    _setting();
  }

  Future<void> _setting() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
  @override
  Stream<LocationData> getLocationStream() {
    return location.onLocationChanged.asBroadcastStream();
  }
}
