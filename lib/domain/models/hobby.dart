import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobby.freezed.dart';

@freezed
class Hobby with _$Hobby {
  const factory Hobby({
    required HobbyType type,
    @Default(false) bool isEqual,
  }) = _Hobby;
}

enum HobbyType {
  alcohol,
  animals,
  restaurants,
  fastFood,
  music,
  videoGames,
  trips,
  wine,
  informationTechnology,
}