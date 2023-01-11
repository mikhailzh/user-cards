import 'package:user_cards/domain/models/user.dart';
import 'package:age_calculator/age_calculator.dart';

extension UserExt on User {
  int get age {
    final duration = AgeCalculator.age(birthday);
    return duration.years;
  }
}