import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
import 'package:user_cards/common/constants/durations.dart';
import 'package:user_cards/domain/interactors/users_interactor.dart';
import 'package:user_cards/domain/models/report.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/models/verdict.dart';
import 'package:user_cards/domain/services/audio_service.dart';
import 'package:user_cards/domain/services/location_service.dart';
import 'package:user_cards/ui/features/app_view_model.dart';

part 'users_view_model.g.dart';

@Injectable(as: UsersViewModel)
class UsersStore = UsersStoreBase with _$UsersStore;

abstract class UsersStoreBase extends UsersViewModel with Store {
  final UserInteractor _interactor;
  final LocationService _locationService;
  final AudioService _audioService;

  @readonly
  List<User> _users = [];
  @readonly
  Stream<double?>? _progress;
  @readonly
  int _currentPage = 0;
  @readonly
  LocationData? _location;

  StreamSubscription? _sub;
  StreamSubscription? _subAudio;
  StreamSubscription? _subLocation;

  var _isRunning = false;
  bool? _isRunningMusic;

  Completer? _completer;

  UsersStoreBase(
    this._interactor,
    this._locationService,
    this._audioService,
  ) {
    _load();
    _settingStream();
  }

  @action
  Future<void> _load() async {
    await _interactor.refreshUsers();
  }

  void _settingStream() {
    _cancelSubs();
    _sub = _interactor.getAll().listen(_updateUsers);
    _subAudio = _audioService.isRunning().listen(_updateAudioRunning);
    _subLocation = _locationService.getLocationStream().listen(_updateLocation);
  }

  void _cancelSubs() {
    _sub?.cancel();
    _sub = null;
    _subAudio?.cancel();
    _subAudio = null;
    _subLocation?.cancel();
    _subLocation = null;
  }

  @action
  void _updateUsers(List<User> users) {
    if (users.isEmpty) return;
    _users = users;
    _currentPage = users.indexWhere((element) => element.verdict == null);
  }

  @action
  void _updateAudioRunning(bool isRunning) {
    _isRunning = isRunning;
    if (!isRunning) {
      _isRunningMusic = null;
      _progress = null;
    }
  }

  @action
  Future<void> _updateLocation(LocationData location) async {
    _location = location;
  }

  @override
  void dispose() {
    _cancelSubs();
    return super.dispose();
  }

  @override
  @action
  Future<void> startAudio(String audioMessage, bool isMusic) async {
    if (_isRunning) {
      await _audioService.pauseAudio();
      if (_isRunningMusic == isMusic) return;
    }
    final progress = (await _audioService.startAudio(audioMessage));
    _isRunningMusic = isMusic;
    if (isMusic) {
      _progress = progress;
    }
  }

  @override
  @action
  Future<void> sendReport(Report report) async {
    final page = _currentPage;
    _users[page] = _users[page].copyWith(verdict: Verdict.report);
    _users = [..._users];
    if (_currentPage + 1 < _users.length) _currentPage++;
    await _interactor.sendReport(_users[page], report);
    await _checkLoadMore();
  }

  @override
  @action
  Future<void> superLike() async {
    await _setVerdict(_currentPage, Verdict.superlike, true);
  }

  @override
  @action
  Future<void> like() async {
    await _setVerdict(_currentPage, Verdict.like, true);
  }

  @override
  @action
  Future<void> onPageChanged(int page) async {
    final prevPage = _currentPage;
    _currentPage = page;
    _checkLoadMore();
    if (prevPage < page) {
      for (var i = prevPage; i < page; i++) {
        _setVerdict(i, Verdict.dislike, false);
      }
    } else {
      for (var i = prevPage; i >= page; i--) {
        _setVerdict(i, null, false);
      }
    }
  }

  Future<void> _checkLoadMore() async {
    if (_currentPage + 2 >= _users.length) {
      await _loadMore();
    }
  }

  @action
  Future<void> _setVerdict(int index, Verdict? verdict, bool checkMore) async {
    await _interactor.setVerdict(_users[index], verdict);
    if (checkMore) await _checkLoadMore();
  }

  Future<void> _loadMore() async {
    if (_completer == null) {
      _completer = Completer();
      await _interactor.loadMore(offset: _users.length);
      _completer?.complete(null);
      _completer = null;
    }
    return _completer?.future;
  }
}

abstract class UsersViewModel extends AppViewModel {
  List<User> get users;

  LocationData? get location;

  Stream<double?>? get progress;

  int get currentPage;

  Future<void> startAudio(String audioMessage, bool isMusic);

  Future<void> sendReport(Report report);

  Future<void> superLike();

  Future<void> like();

  Future<void> onPageChanged(int page);
}
