import 'package:get_it/get_it.dart';
import 'api/ai_api_request.dart';
import 'api/api_request.dart';
import 'api/dio_api_impl.dart';

import 'api/ai_dio_api_impl.dart';
import 'drawer/controller/tfit_drawer_controller.dart';

sealed class CoreInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<AppDrawerController>(() => AppDrawerController());
    injector.registerLazySingleton<ApiRequest>(() => DioApiImpl());
    injector.registerLazySingleton<AIApiRequest>(() => AIDioApiImpl());

  }
}
