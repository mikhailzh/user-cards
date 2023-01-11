import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:user_cards/common/constants/durations.dart';
import 'package:user_cards/common/constants/environment.dart';
import 'package:user_cards/common/extensions/list_ext.dart';
import 'package:user_cards/domain/models/hobby.dart';
import 'package:user_cards/domain/models/language.dart';
import 'package:user_cards/domain/models/location.dart';
import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/models/user_goal.dart';
import 'package:user_cards/domain/models/verdict.dart';
import 'package:user_cards/domain/repositories/users/remote_users_repository.dart';

@LazySingleton(as: RemoteUserRepository, env: AppEnvironment.mocks)
class MockRemoteUserRepository extends RemoteUserRepository {
  var _sumOffsets = 2;

  @override
  Future<void> clearVerdict(int id) async {
    await Future.delayed(MockDuration.oneSecond);
  }

  @override
  Future<User> getCurrentUser() async {
    _sumOffsets += 10001;
    final random = _getRandom();
    return _getRandomUser(
      0,
      random,
      true,
    );
  }

  @override
  Future<List<User>> getUsers(int offset, int limit) async {
    _sumOffsets += offset;
    final random = _getRandom();
    return List.generate(
      limit,
      (index) => _getRandomUser(
        index + offset,
        random,
        false,
      ),
    );
  }

  @override
  Future<List<User>> refresh(int limit) async {
    _sumOffsets += 10000;
    return getUsers(0, limit);
  }

  @override
  Future<void> setVerdict(int id, Verdict? verdict) async {
    await Future.delayed(MockDuration.oneSecond);
  }

  Random _getRandom() {
    return Random(_sumOffsets);
  }

  User _getRandomUser(int id, Random random, bool isCurrentUser) => User(
        id: id + 1,
        name: _names.random(random),
        location: _locations.random(random),
        birthday: DateTime.fromMillisecondsSinceEpoch(
            (random.nextDouble() * (_maxBirthday - _minBirthday)).toInt() + _minBirthday),
        goal: UserGoal.values.random(random),
        images: _photos.random(random),
        hobbies: List.generate(
          random.nextInt(5) + 1,
          (index) => Hobby(type: HobbyType.values.random(random)),
        ),
        language: Language.values.random(random),
        audioMessage: _audioMessages.random(random),
        music: _music.random(random),
        isCurrentUser: isCurrentUser,
        verdict: null,
      );

  @override
  Future<void> sendReport(int id, Report report) async {
    await Future.delayed(MockDuration.oneSecond);
  }
}

const _minBirthday = 820436400000;
const _maxBirthday = 1041361200000;

const _photos = [
  [
    "https://sun3.userapi.com/sun3-17/s/v1/ig2/jdClh9e0hI4RDJT1v7V3q2UAEwCy20DxcJ8ztsT5_Bkgix5duDG4LsJfqwyMOoaQdO_U_DsBKTIcGqREbUTGzY7x.jpg?size=853x1280&quality=95&type=album",
    "https://sun3.userapi.com/sun3-16/s/v1/ig2/nthlzhn38LS1OlwDbtL_Jz8JWjQx3X5jjf7bHNTjgqiKIJve4XVeQLB3ZCM2nqeOGXNNOYmaZ9z6B2OdoOrOxz2J.jpg?size=1280x854&quality=95&type=album",
    "https://sun3.userapi.com/sun3-12/s/v1/ig2/-Ec1i3eYgZP070w8k85FiVdNk5LEmfGzjJk6kQNyaSk3U0Za3MiVgZ9YjhsbhC3i3InYlE4CLK_Mj2ip131DzuQG.jpg?size=1280x1083&quality=95&type=album",
  ],
  [
    "https://sun9-31.userapi.com/c10412/u44785776/127370290/y_c51fda92.jpg",
  ],
  [
    "https://sun3.userapi.com/sun3-16/s/v1/ig2/sdxEj3BtzxEWvVYelpgkulEZ4xajQvdD672x2fNylQQM93L6-98HvTwONYQogsElyOtbbxckkzbQnpsO6u36YFb4.jpg?size=591x1042&quality=95&type=album",
    "https://sun9-76.userapi.com/c1357/u2850237/38183849/x_70714931.jpg",
    "https://sun9-east.userapi.com/sun9-73/s/v1/if1/up8idqRx7oKBRIaNfq9ljEEtMs8Bjb6YPwFHBy9r4xt_4ZSKIPOA7NJOkdM60f92w-WUmffp.jpg?size=969x706&quality=96&type=album",
    "https://sun9-west.userapi.com/sun9-1/s/v1/ig2/5580SSkWOO8U_RbTJhdPsI4AeEwWH_4VnAdFtBcNe8HrejI-LYMrP4FKBdEFB90rqbdBJaJO2wXxa8CmjFB2wDa9.jpg?size=852x1280&quality=96&type=album",
  ],
  [
    "https://sun9-east.userapi.com/sun9-18/s/v1/ig2/f0PDgFr4dfTUZEEW9A_bMlDpua8_d9c1B4iaYHuWM-1gtYeSC71_ft7OQRHQTL6t6GvoaR7GqJzF2vP-ijirZKHy.jpg?size=1439x2160&quality=95&type=album",
    "https://sun9-east.userapi.com/sun9-34/s/v1/ig2/eDavOtZAS1p5f1PjnpABOX3u8n_hy4c40E091PhvRXOV-5M71MffVuVZSr4Pqi3-hxTisa3vwyLh69HeKlTOa25C.jpg?size=1333x2000&quality=95&type=album",
  ],
];

const _names = ["John", "Vanya", "Harry", "Jacob", "Otabek"];

const _locations = [
  Location(
    latitude: 41.28484709718822,
    longitude: 69.26598947778113,
    name: "Ташкент",
  ),
  Location(
    latitude: 39.62896140981413,
    longitude: 66.95892333984376,
    name: "Самарканд",
  ),
  Location(
    latitude: 42.83569550641454,
    longitude: 74.60815429687501,
    name: "Бишкек",
  ),
  Location(
    latitude: 43.197167282501276,
    longitude: 76.937255859375,
    name: "Алматы",
  ),
  Location(
    latitude: 41.64007838467894,
    longitude: 44.80224609375001,
    name: "Тбилиси",
  ),
  Location(
    latitude: 37.50972584293751,
    longitude: 127.00195312500001,
    name: "Сеул",
  ),
];

const _music = [
  "music/audio_0.mp3",
  "music/audio_1.mp3",
  "music/audio_2.mp3",
  "music/audio_3.mp3",
  "music/audio_4.mp3",
];

const _audioMessages = [
  "audio/audio_0.mp3",
  "audio/audio_1.mp3",
  "audio/audio_2.mp3",
  "audio/audio_3.mp3",
  "audio/audio_4.mp3",
];
