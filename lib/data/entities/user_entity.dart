import 'package:objectbox/objectbox.dart';
import 'package:user_cards/data/entities/image_entity.dart';
import 'package:user_cards/data/extensions/hobby_ext.dart';
import 'package:user_cards/data/extensions/language_ext.dart';
import 'package:user_cards/data/extensions/user_goal_ext.dart';
import 'package:user_cards/data/extensions/verdict_ext.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/domain/models/language.dart';
import 'package:user_cards/domain/models/location.dart';
import 'package:user_cards/domain/models/user_goal.dart';
import 'package:user_cards/domain/models/verdict.dart';

@Entity()
class UserEntity {
  @Id(assignable: true)
  int id;
  String name;
  String locationName;
  double locationLatitude;
  double locationLongitude;
  DateTime birthday;
  @Transient()
  UserGoal goal;
  ToMany<ImageEntity> images;
  @Transient()
  List<HobbyType> hobbies;
  @Transient()
  Language language;
  String audioMessage;
  String music;
  bool isCurrentUser;
  @Transient()
  Verdict? verdict;

  UserEntity({
    required this.id,
    required this.name,
    required this.locationName,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.birthday,
    this.goal = UserGoal.date,
    required this.images,
    this.hobbies = const [],
    this.language = Language.english,
    required this.audioMessage,
    required this.music,
    required this.isCurrentUser,
    this.verdict,
  });

  UserEntity.create({
    required int id,
    required String name,
    required Location location,
    required DateTime birthday,
    required UserGoal goal,
    required List<String> images,
    required List<HobbyType> hobbies,
    required Language language,
    required String audioMessage,
    required String music,
    required bool isCurrentUser,
    required Verdict? verdict,
  }) : this(
          id: id,
          name: name,
          locationName: location.name,
          locationLatitude: location.latitude,
          locationLongitude: location.longitude,
          birthday: birthday,
          goal: goal,
          images: ToMany(items: images.map((e) => ImageEntity(id: 0, userId: id, href: e,)).toList()),
          hobbies: hobbies,
          language: language,
          audioMessage: audioMessage,
          music: music,
          isCurrentUser: isCurrentUser,
          verdict: verdict,
        );

  int get languageOb {
    return language.obIndex;
  }

  set languageOb(int index) {
    language = LanguageExt.fromObIndex(index);
  }

  int get verdictOb {
    return verdict?.obIndex ?? 0;
  }

  set verdictOb(int index) {
    verdict = VerdictExt.fromObIndex(index);
  }

  int get goalOb {
    return goal.obIndex;
  }

  set goalOb(int index) {
    goal = UserGoalExt.fromObIndex(index);
  }

  int get hobbiesOb {
    return hobbiesToInt(hobbies);
  }

  set hobbiesOb(int value) {
    hobbies = intToDaysOfWeek(value);
  }
}
