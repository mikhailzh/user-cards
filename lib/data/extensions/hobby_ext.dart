import 'package:user_cards/domain/models/hobby.dart';

int hobbiesToInt(List<HobbyType> hobbies) {
  int result = 0;
  for (final day in hobbies) {
    result = result | (1 << day.value);
  }
  return result;
}

List<HobbyType> intToDaysOfWeek(int value) {
  var result = <HobbyType>[];
  for (final hobby in HobbyType.values) {
    if (value & (1 << hobby.value) != 0) result.add(hobby);
  }
  return result;
}

extension HobbyExt on HobbyType {
  int get value {
    switch (this) {
      case HobbyType.alcohol:
        return 0;
      case HobbyType.animals:
        return 1;
      case HobbyType.restaurants:
        return 2;
      case HobbyType.fastFood:
        return 3;
      case HobbyType.music:
        return 4;
      case HobbyType.videoGames:
        return 5;
      case HobbyType.trips:
        return 6;
      case HobbyType.wine:
        return 7;
      case HobbyType.informationTechnology:
        return 8;
    }
  }
}
