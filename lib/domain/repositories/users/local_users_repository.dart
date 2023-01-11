import 'package:user_cards/domain/models/user.dart';

abstract class LocalUserRepository {
  Stream<List<User>> getAll();

  Future<void> clear();

  Future<void> saveAll(List<User> users);

  Future<void> update(User user);
}
