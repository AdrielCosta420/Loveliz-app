import 'package:get_it/get_it.dart';
import 'package:loveliz_app/src/core/api/api_request.dart';
import 'package:loveliz_app/src/core/api/dio_api_impl.dart';

import 'drawer/controller/tfit_drawer_controller.dart';

sealed class CoreInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<AppDrawerController>(() => AppDrawerController());
    injector.registerLazySingleton<ApiRequest>(() => DioApiImpl());

  }
}
