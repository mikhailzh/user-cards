import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/domain/models/hobby.dart';

extension HobbyExt on Hobby {
  String get text {
    switch (type) {
      case HobbyType.alcohol:
        return Strings.hobby.alcohol();
      case HobbyType.animals:
        return Strings.hobby.animals();
      case HobbyType.restaurants:
        return Strings.hobby.restaurants();
      case HobbyType.fastFood:
        return Strings.hobby.fastFood();
      case HobbyType.music:
        return Strings.hobby.music();
      case HobbyType.videoGames:
        return Strings.hobby.videoGames();
      case HobbyType.trips:
        return Strings.hobby.trips();
      case HobbyType.wine:
        return Strings.hobby.wine();
      case HobbyType.informationTechnology:
        return Strings.hobby.informationTechnology();
    }
  }
}
