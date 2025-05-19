import 'package:get_it/get_it.dart';

import 'data/repositories/user_repository_impl.dart';
import 'data/services/user_service.dart';
import 'data/services/user_service_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/get_user_uc.dart';
import 'presentation/controllers/user_controller.dart';

sealed class UserInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<UserController>(() => UserController());
    injector.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
    injector.registerLazySingleton<UserService>(() => UserServiceImpl());
    injector.registerLazySingleton<GetUserUc>(() => GetUserUcImpl());
  }
}