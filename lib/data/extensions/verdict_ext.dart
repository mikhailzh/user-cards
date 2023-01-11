import 'package:user_cards/domain/models/verdict.dart';

extension VerdictExt on Verdict {
  get obIndex {
    switch (this) {
      case Verdict.superlike: return 1;
      case Verdict.dislike: return 2;
      case Verdict.report: return 3;
      case Verdict.like: return 4;
    }
  }

  static Verdict? fromObIndex(int index) {
    switch (index) {
      case 1: return Verdict.superlike;
      case 2: return Verdict.dislike;
      case 3: return Verdict.report;
      case 4: return Verdict.like;
      default: return null;
    }
  }
}
