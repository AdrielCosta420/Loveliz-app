import 'package:get_it/get_it.dart';
import 'package:loveliz_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:loveliz_app/src/modules/auth/repositories/auth_repository.dart';
import 'package:loveliz_app/src/modules/auth/services/auth_service.dart';
import 'package:loveliz_app/src/modules/auth/uc/login_uc.dart';

sealed class AuthInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<AuthService>(() => AuthServiceImpl());
    injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
    injector.registerLazySingleton<AuthController>(() => AuthController());
    injector.registerLazySingleton<LoginUc>(() => LoginUcImpl());
  }
}
