import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/domain/models/verdict.dart';

extension VerdictExt on Verdict {
  String get text {
    switch (this) {
      case Verdict.like:
        return Strings.verdict.like();
      case Verdict.superlike:
        return Strings.verdict.superlike();
      case Verdict.dislike:
        return Strings.verdict.dislike();
      case Verdict.report:
        return Strings.verdict.report();
    }
  }
}
