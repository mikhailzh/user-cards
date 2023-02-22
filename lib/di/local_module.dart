import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:user_cards/objectbox.g.dart';
/// di - содержит настройки dependency injection и модули
@module
abstract class LocalModule {
  @lazySingleton
  @preResolve
  Future<Store> storage() => openStore();
}
