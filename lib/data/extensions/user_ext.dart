import 'package:user_cards/data/entities/user_entity.dart';
import 'package:user_cards/domain/models/user.dart';

extension UserExt on User {
  UserEntity toEntity() => UserEntity.create(
        id: id,
        name: name,
        location: location,
        birthday: birthday,
        goal: goal,
        images: images,
        hobbies: hobbies.map((e) => e.type).toList(),
        language: language,
        audioMessage: audioMessage,
        music: music,
        isCurrentUser: isCurrentUser,
        verdict: verdict,
      );
}
