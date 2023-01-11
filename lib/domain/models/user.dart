import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/domain/models/language.dart';
import 'package:user_cards/domain/models/location.dart';
import 'package:user_cards/domain/models/user_goal.dart';
import 'package:user_cards/domain/models/verdict.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required DateTime birthday,
    required Location location,
    required UserGoal goal,
    required List<String> images,
    required List<Hobby> hobbies,
    required Language language,
    required String audioMessage,
    required String music,
    required bool isCurrentUser,
    required Verdict? verdict,
  }) = _User;
}
