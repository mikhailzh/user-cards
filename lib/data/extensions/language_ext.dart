import 'package:user_cards/domain/models/language.dart';

extension LanguageExt on Language {
  get obIndex {
    switch (this) {
      case Language.italian:
        return 1;
      case Language.french:
        return 2;
      case Language.spanish:
        return 3;
      case Language.german:
        return 4;
      case Language.dutch:
        return 5;
      case Language.russian:
        return 6;
      case Language.japanese:
        return 7;
      case Language.portuguese:
        return 8;
      case Language.english:
        return 9;
    }
  }

  static Language fromObIndex(int index) {
    switch (index) {
      case 1:
        return Language.italian;
      case 2:
        return Language.french;
      case 3:
        return Language.spanish;
      case 4:
        return Language.german;
      case 5:
        return Language.dutch;
      case 6:
        return Language.russian;
      case 7:
        return Language.japanese;
      case 8:
        return Language.portuguese;
      case 9:
        return Language.english;
      default:
        return Language.english;
    }
  }
}
