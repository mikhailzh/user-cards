import 'package:location/location.dart';
/// domain - содержит абстракции всех бизнес-классов приложения и бизнес-модели
///
/// service - все что не попадает под описание interactor или repository
abstract class LocationService {
  Stream<LocationData> getLocationStream();
}
