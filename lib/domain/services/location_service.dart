import 'package:location/location.dart';

abstract class LocationService {
  Stream<LocationData> getLocationStream();
}
