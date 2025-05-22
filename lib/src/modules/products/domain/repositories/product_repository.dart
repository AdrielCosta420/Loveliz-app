import '../../../../common/result/result.dart';
import '../errors/collection_product_error.dart';
import '../errors/product_error.dart';
import '../models/collection_product.dart';
import '../models/product.dart';

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