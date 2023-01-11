import 'package:intl/intl.dart';

abstract class Strings {
  static final users = UsersStrings();
  static final goal = UserGoalStrings();
  static final language = LanguageStrings();
  static final location = LocationStrings();
  static final hobby = HobbyStrings();
  static final verdict = VerdictStrings();
}

class UserGoalStrings {
  String friends() => Intl.message("💬 friends");

  String date() => Intl.message("💬 date");
}

class LanguageStrings {
  String english() => Intl.message("🇬🇧");
  String italian() => Intl.message("🇮🇹");
  String french() => Intl.message("🇫🇷");
  String spanish() => Intl.message("🇪🇸");
  String german() => Intl.message("🇩🇪");
  String dutch() => Intl.message("🇳🇱");
  String russian() => Intl.message("🇷🇺");
  String japanese() => Intl.message("🇯🇵");
  String portuguese() => Intl.message("🇵🇹");
}

class UsersStrings {
  String cancel() => Intl.message("Cancel");
  String report() => Intl.message("Report");
  String spam() => Intl.message("Spam");
  String fake() => Intl.message("Fake");
  String hasMessages() => Intl.message("📬");
  String noMessages() => Intl.message("📫");
  String boost() => Intl.message("⚡️");
  String instantMatch() => Intl.message("💌️");
  String superLike() => Intl.message("🤩");
  String sendMessage() => Intl.message("📤");
}

class LocationStrings {
  String nameWithDistance(String name, int distance) => Intl.message("$name, $distance km");
}

class HobbyStrings {
  String alcohol() => Intl.message("🥃");
  String animals() => Intl.message("🐶");
  String restaurants() => Intl.message("🍽");
  String fastFood() => Intl.message("🍔");
  String music() => Intl.message("🎧");
  String videoGames() => Intl.message("🎮");
  String trips() => Intl.message("🛩");
  String wine() => Intl.message("🍷");
  String informationTechnology() => Intl.message("💻");
}

class VerdictStrings {
  String like() => Intl.message("❤️");
  String superlike() => Intl.message("🤩");
  String dislike() => Intl.message("💔");
  String report() => Intl.message("🆘");
}
