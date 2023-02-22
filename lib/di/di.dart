import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
/// di - содержит настройки dependency injection(основной файл на подобие этого) и модули
final GetIt getIt = GetIt.instance;

@InjectableInit(asExtension: true, initializerName: 'init')
Future<GetIt> getItInit({String? env, EnvironmentFilter? environmentFilter}) async {
  return await getIt.init(environmentFilter: environmentFilter, environment: env);
}

void resetGetIt<T extends Object>({
  Object? instance,
  String? instanceName,
  void Function(T)? disposingFunction,
}) {
  getIt.resetLazySingleton<T>(instance: instance, instanceName: instanceName, disposingFunction: disposingFunction);
}
