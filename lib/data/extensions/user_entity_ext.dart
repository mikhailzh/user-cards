import 'package:user_cards/data/entities/user_entity.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/domain/models/location.dart';
import 'package:user_cards/domain/models/user.dart';

extension UserEntityExt on UserEntity {
  User toModel(User? currentUser) {
    return User(
      id: id,
      name: name,
      location: Location(
        latitude: locationLatitude,
        longitude: locationLongitude,
        name: locationName,
      ),
      birthday: birthday,
      goal: goal,
      images: images.map((e) => e.href).toList(),
      hobbies: hobbies.map((e) => Hobby(
            type: e,
            isEqual: currentUser?.hobbies.any((element) => element.type == e) == true,
          )).toList(),
      language: language,
      audioMessage: audioMessage,
      music: music,
      isCurrentUser: isCurrentUser,
      verdict: verdict,
    );
  }
}
