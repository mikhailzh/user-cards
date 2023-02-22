import 'package:injectable/injectable.dart';
import 'package:user_cards/domain/interactors/users_interactor.dart';
import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/models/verdict.dart';
import 'package:user_cards/domain/repositories/users/local_users_repository.dart';
import 'package:user_cards/domain/repositories/users/remote_users_repository.dart';
/// data - содержит релизацию абстракций domain и вспомогательные для этого файлы
///
/// interactor - получает данные из репозиториев, содержит часть логики приложения, работает с сервисами
const _defaultSize = 3;
const _firstSize = 2 * _defaultSize;

@Singleton(as: UserInteractor)
class DefaultUserInteractor extends UserInteractor {
  final LocalUserRepository _localRepository;
  final RemoteUserRepository _remoteRepository;

  DefaultUserInteractor(
    this._remoteRepository,
    this._localRepository,
  );

  @override
  Future<void> clearVerdict(User user) async {
    await _remoteRepository.clearVerdict(user.id);
    await _localRepository.update(user.copyWith(verdict: null));
  }

  @override
  Stream<List<User>> getAll() {
    return _localRepository.getAll();
  }

  @override
  Future<void> loadMore({required int offset}) async {
    final users = await _remoteRepository.getUsers(offset, _defaultSize);
    await _localRepository.saveAll(users);
  }

  @override
  Future<void> refreshUsers() async {
    final users = await _remoteRepository.getUsers(0, _firstSize);
    final currentUser = await _remoteRepository.getCurrentUser();
    await _localRepository.clear();
    await _localRepository.saveAll(users + [currentUser]);
  }

  @override
  Future<void> setVerdict(User user, Verdict? verdict) async {
    await _localRepository.update(user.copyWith(verdict: verdict));
    await _remoteRepository.setVerdict(user.id, verdict);
  }

  @override
  Future<void> sendReport(User user, Report report) async {
    await _remoteRepository.sendReport(user.id, report);
    await setVerdict(user, Verdict.report);
  }
}
