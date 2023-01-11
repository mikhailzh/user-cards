import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/models/verdict.dart';

abstract class RemoteUserRepository {
  Future<List<User>> refresh(int limit);

  Future<List<User>> getUsers(int offset, int limit);

  Future<User> getCurrentUser();

  Future<void> setVerdict(int id, Verdict? verdict);

  Future<void> sendReport(int id, Report report);

  Future<void> clearVerdict(int id);
}
