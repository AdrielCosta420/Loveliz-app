import 'package:get_it/get_it.dart';
import 'repositories/product_repository.dart';
import 'services/product_service.dart';
import 'domain/uc/get_products_uc.dart';

import 'controllers/product_controller.dart';

sealed class ProductInjector {
  static void inject(GetIt injector) {

    injector.registerLazySingleton<ProductController>(() => ProductController());
    injector.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
    injector.registerLazySingleton<ProductService>(() => ProductServiceImpl());
    injector.registerLazySingleton<GetProductsUc>(() => GetProductsUcImpl());
  }
}