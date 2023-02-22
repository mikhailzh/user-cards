import 'package:user_cards/domain/models/user.dart';
/// domain - содержит абстракции всех бизнес-классов приложения и бизнес-модели
///
/// repository - получает и записывает данные из определенного источника
abstract class LocalUserRepository {
  Stream<List<User>> getAll();

  Future<void> clear();

  Future<void> saveAll(List<User> users);

  Future<void> update(User user);
}
