import 'package:get_it/get_it.dart';
import '../../data/repositories/sale_repository_impl.dart';
import '../../data/service/sale_service.dart';
import '../../data/service/sale_service_impl.dart';
import '../../domain/repositories/sale_repository.dart';
import '../../domain/usecases/get_last_sale_uc.dart';
import '../../domain/usecases/get_sales_uc.dart';
import '../controllers/sale_controller.dart';

sealed class SaleInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<SaleController>(() => SaleController());
    injector.registerLazySingleton<SaleRepository>(() => SaleRepositoryImpl());
    injector.registerLazySingleton<SaleService>(() => SaleServiceImpl());
    injector.registerLazySingleton<GetSalesUc>(() => GetSalesUcImpl());
    injector.registerLazySingleton<GetLastSaleUc>(() => GetLastSaleUcImpl());
  }
}
