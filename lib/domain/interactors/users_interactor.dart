import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/models/verdict.dart';

abstract class UserInteractor {
  Stream<List<User>> getAll();

  Future<void> loadMore({required int offset});

  Future<void> setVerdict(User user, Verdict? verdict);

  Future<void> sendReport(User user, Report report);

  Future<void> clearVerdict(User user);

  Future<void> refreshUsers();
}
