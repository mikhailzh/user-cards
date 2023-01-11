import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:user_cards/data/entities/image_entity.dart';
import 'package:user_cards/data/entities/user_entity.dart';
import 'package:user_cards/data/extensions/user_entity_ext.dart';
import 'package:user_cards/data/extensions/user_ext.dart';
import 'package:user_cards/di/di.dart';
import 'package:user_cards/domain/models/user.dart';
import 'package:user_cards/domain/repositories/users/local_users_repository.dart';
import 'package:user_cards/objectbox.g.dart';

@LazySingleton(as: LocalUserRepository)
class ObjectBoxLocalUserRepository extends LocalUserRepository {
  final Store _store = getIt();
  late Box<UserEntity> _userBox;
  late Box<ImageEntity> _imageBox;

  ObjectBoxLocalUserRepository() {
    _userBox = _store.box();
    _imageBox = _store.box();
  }

  @override
  Future<void> clear() async {
    _userBox.removeAll();
  }

  @override
  Stream<List<User>> getAll() {
    return _userBox
        .query(UserEntity_.isCurrentUser.equals(false))
        .order(UserEntity_.id)
        .watch(triggerImmediately: true)
        .map((e) {
      final current = _userBox.query(UserEntity_.isCurrentUser.equals(true)).build().findFirst()?.toModel(null);
      return e.find().map((e) => e.toModel(current)).toList();
    });
  }

  @override
  Future<void> saveAll(List<User> users) async {
    final userIds = users.map((e) => e.id).toList();
    final imageIds = _imageBox.query(ImageEntity_.userId.oneOf(userIds)).build().findIds();
    _imageBox.removeMany(imageIds);
    _userBox.putMany(users.map((e) => e.toEntity()).toList(), mode: PutMode.put);
  }

  @override
  Future<void> update(User user) async {
    final imageIds = _imageBox.query(ImageEntity_.userId.equals(user.id)).build().findIds();
    _imageBox.removeMany(imageIds);
    _userBox.put(user.toEntity());
  }
}
