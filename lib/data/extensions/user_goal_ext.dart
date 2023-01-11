import 'package:user_cards/domain/models/user_goal.dart';

extension UserGoalExt on UserGoal {
  get obIndex {
    switch (this) {
      case UserGoal.friends:
        return 1;
      case UserGoal.date:
        return 2;
    }
  }

  static UserGoal fromObIndex(int index) {
    switch (index) {
      case 1:
        return UserGoal.friends;
      case 2:
        return UserGoal.date;
      default:
        return UserGoal.date;
    }
  }
}