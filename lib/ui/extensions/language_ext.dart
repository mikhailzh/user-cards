import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/domain/models/language.dart';
import 'package:user_cards/domain/models/user_goal.dart';

extension LanguageExt on Language {
  String get text {
    switch (this) {
      case Language.english: return Strings.language.english();
      case Language.italian: return Strings.language.italian();
      case Language.french: return Strings.language.french();
      case Language.spanish: return Strings.language.spanish();
      case Language.german: return Strings.language.german();
      case Language.dutch: return Strings.language.dutch();
      case Language.russian: return Strings.language.russian();
      case Language.japanese: return Strings.language.japanese();
      case Language.portuguese: return Strings.language.portuguese();
    }
  }
}
