import 'package:get_it/get_it.dart';

import 'data/repositories/report_repository_impl.dart';
import 'data/services/report_service.dart';
import 'data/services/report_service_impl.dart';
import 'domain/repositories/report_repository.dart';
import 'domain/usecases/initialize_reports_data_uc.dart';
import 'presentation/controllers/report_controller.dart';

sealed class ReportInjector {
  static void inject(GetIt injector) {
    
     injector.registerLazySingleton<ReportService>(() => ReportServiceImpl());
     injector.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl());
    injector.registerLazySingleton<ReportController>(() => ReportController());
    injector.registerLazySingleton<InitializeReportsDataUc>(() => InitializeReportsDataUcImpl());
  }
}
