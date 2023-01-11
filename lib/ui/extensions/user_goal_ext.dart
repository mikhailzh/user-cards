import 'package:user_cards/common/constants/strings.dart';
import 'package:user_cards/domain/models/user_goal.dart';

extension UserGoalExt on UserGoal {
  String get text {
    switch (this) {
      case UserGoal.friends:
        return Strings.goal.friends();
      case UserGoal.date:
        return Strings.goal.date();
    }
  }
}
