
import 'package:loveliz_app/src/core/api/api_exception.dart';
import 'package:loveliz_app/src/modules/products/services/product_service.dart';

import '../../../common/result/result.dart';
import '../../../injectable.dart';
import '../domain/errors/product_error.dart';
import '../domain/models/product.dart';

abstract interface class ProductRepository {
  Future<Result<ProductError, List<Product>>> getProducts();
  Future<Result<ProductError, Product>> createProduct({required Product product});
  Future<Result<ProductError, String>> deleteProduct({required String id});
  // Future<Result<ProductError,Product>> updateProduct({required Product product});
}

class ProductRepositoryImpl implements ProductRepository {
  final service = injector.get<ProductService>();

  @override
  Future<Result<ProductError, Product>> createProduct({required Product product}) async {
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
  Future<Result<ProductError, String>> deleteProduct({required String id}) async {
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
      final response = await service.getProducts();
    
      
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
}
