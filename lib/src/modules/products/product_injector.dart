import 'package:get_it/get_it.dart';
import 'controllers/collection_product_controller.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/uc/create_collection_product_uc.dart';
import 'domain/uc/create_product_uc.dart';
import 'domain/uc/get_collections_product_uc.dart';
import 'domain/uc/get_products_by_collection_uc.dart';
import 'domain/uc/get_top_products_uc.dart';
import 'domain/uc/update_collection_product_uc.dart';
import 'domain/uc/update_product_uc.dart';
import 'domain/uc/update_status_product_uc.dart';
import 'repositories/product_repository.dart';
import 'services/product_service.dart';
import 'domain/uc/get_products_uc.dart';

import 'controllers/product_controller.dart';

sealed class ProductInjector {
  static void inject(GetIt injector) {

    injector.registerLazySingleton<ProductController>(() => ProductController());
    injector.registerLazySingleton<CollectionProductController>(() => CollectionProductController());
    injector.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl());
    injector.registerLazySingleton<ProductService>(() => ProductServiceImpl());
    injector.registerLazySingleton<GetProductsUc>(() => GetProductsUcImpl());
    injector.registerLazySingleton<GetTopProductsUc>(() => GetTopProductsUcImpl());
    injector.registerLazySingleton<GetCollectionsProductUc>(() => GetCollectionsProductUcImpl());
    injector.registerLazySingleton<GetProductsByCollectionUc>(() => GetProductsByCollectionUcImpl());
    injector.registerLazySingleton<CreateCollectionProductUc>(() => CreateCollectionProductUcImpl());
    injector.registerLazySingleton<UpdateCollectionProductUc>(() => UpdateCollectionProductUcImpl());
    injector.registerLazySingleton<CreateProductUc>(() => CreateProductUcImpl());
    injector.registerLazySingleton<UpdateProductUc>(() => UpdateProductUcImpl());
    injector.registerLazySingleton<UpdateStatusProductUc>(() => UpdateStatusProductUcImpl());
  }
}