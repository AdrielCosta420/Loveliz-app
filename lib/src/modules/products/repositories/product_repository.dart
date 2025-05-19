import 'package:loveliz_app/src/core/api/api_exception.dart';
import '../domain/errors/collection_product_error.dart';
import '../domain/models/collection_product.dart';
import '../services/product_service.dart';

import '../../../common/result/result.dart';
import '../../../injectable.dart';
import '../domain/errors/product_error.dart';
import '../domain/models/product.dart';

abstract interface class ProductRepository {
  Future<Result<ProductError, List<Product>>> getProducts();
  Future<Result<ProductError, Product>> createProduct({
    required Product product,
  });
  Future<Result<ProductError, Product>> updateProduct({
    required Product product,
  });
  Future<Result<ProductError, String>> updateStatusProduct({
    required String id,
    required bool active,
  });
  Future<Result<ProductError, String>> deleteProduct({required String id});
  Future<Result<ProductError, List<Product>>> getTopProducts();
  Future<Result<CollectionProductError, List<CollectionProduct>>> getCollectionsProduct();
  Future<Result<CollectionProductError, CollectionProduct>> createCollectionProduct({required String name});
  Future<Result<CollectionProductError, CollectionProduct>> updateCollectionProduct({required String id, required String name});
  Future<Result<ProductError, List<Product>>> getProductsByCollection({required String id});
}

class ProductRepositoryImpl implements ProductRepository {
  final service = injector.get<ProductService>();

  @override
  Future<Result<ProductError, Product>> createProduct({
    required Product product,
  }) async {
    try {
      final response = await service.createProduct(product: product);
      return Result.success(Product.fromMap(response));
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }

   @override
  Future<Result<ProductError, Product>> updateProduct({required Product product}) async {
    
    try {
      final response = await service.updateProduct(product: product);
      return Result.success(Product.fromMap(response));
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }

  @override
  Future<Result<ProductError, String>> deleteProduct({
    required String id,
  }) async {
    try {
      final response = await service.deleteProduct(id: id);
      return Result.success(response['message']);
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }

  @override
  Future<Result<ProductError, List<Product>>> getProducts() async {
    try {
      final response = await service.getTopProducts();

      final products = <Product>[];
      for (var element in response) {
        products.add(Product.fromMap(element));
      }
      return Result.success(products);
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }

  @override
  Future<Result<ProductError, List<Product>>> getTopProducts() async {
    try {
      final response = await service.getTopProducts();

      final products = <Product>[];
      for (var element in response) {
        products.add(Product.fromMap(element));
      }
      return Result.success(products);
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }

  @override
  Future<Result<CollectionProductError, CollectionProduct>>
  createCollectionProduct({required String name}) async {
    try {
      final response = await service.createCollectionProduct(name: name);
      return Result.success(CollectionProduct.fromMap(response));
    } on ApiException catch (e) {
      return Result.failure(CollectionProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(CollectionProductError(e.toString()));
    }
  }

  @override
  Future<Result<CollectionProductError, List<CollectionProduct>>>
  getCollectionsProduct() async {
    try {
      final response = await service.getCollectionsProduct();
      final collections = <CollectionProduct>[];

      for (var collection in response) {
        collections.add(CollectionProduct.fromMap(collection));
      }
      return Result.success(collections);
    } on ApiException catch (e) {
      return Result.failure(CollectionProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(CollectionProductError(e.toString()));
    }
  }

  @override
  Future<Result<CollectionProductError, CollectionProduct>>
  updateCollectionProduct({required String id, required String name}) async {
    try {
      final response = await service.updateCollectionProduct(id: id, name: name);
      return Result.success(CollectionProduct.fromMap(response));
    } on ApiException catch (e) {
      return Result.failure(CollectionProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(CollectionProductError(e.toString()));
    }
  }
  
  @override
  Future<Result<ProductError, List<Product>>> getProductsByCollection({required String id}) async {
    try {
      final response = await service.getProductsByCollection(id: id);

      final products = <Product>[];
      for (var element in response) {
        products.add(Product.fromMap(element));
      }
      return Result.success(products);
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }
  
  @override
  Future<Result<ProductError, String>> updateStatusProduct({required String id, required bool active}) async {
    try {
      final response = await service.updateStatusProduct(id: id, active: active);
      return Result.success(response['message']);
    } on ApiException catch (e) {
      return Result.failure(ProductError(e.message));
    } on Exception catch (e) {
      return Result.failure(ProductError(e.toString()));
    }
  }
  
 
}
