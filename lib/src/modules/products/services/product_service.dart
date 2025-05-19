import 'package:loveliz_app/src/common/typedef/typedef.dart';
import 'package:loveliz_app/src/core/api/api_exception.dart';
import 'package:loveliz_app/src/modules/products/domain/errors/product_error.dart';
import 'package:loveliz_app/src/modules/products/domain/models/product.dart';

import '../../../core/api/api_request.dart';
import '../../../injectable.dart';
import '../domain/errors/collection_product_error.dart';

abstract interface class ProductService {
  Future<dynamic> getProducts();
  Future<ApiResponse> createProduct({required Product product});
  Future<ApiResponse> updateProduct({required Product product});
  Future<ApiResponse> deleteProduct({required String id});
  Future<ApiResponse> updateStatusProduct({
    required String id,
    required bool active,
  });
  Future<dynamic> getTopProducts();
  Future<dynamic> getCollectionsProduct();
  Future<ApiResponse> createCollectionProduct({required String name});
  Future<ApiResponse> updateCollectionProduct({
    required String id,
    required String name,
  });
  Future<dynamic> getProductsByCollection({required String id});
}

class ProductServiceImpl implements ProductService {
  final api = injector.get<ApiRequest>();

  @override
  Future<ApiResponse> createProduct({required Product product}) async {
    try {
      return await api.post(path: '/product', body: product.toMap());
    } on ApiException catch (e) {
      throw ProductError(e.message);
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }

  @override
  Future<ApiResponse> updateProduct({required Product product}) async {
    try {
      return await api.patch(path: '/product', body: product.toMap());
    } on ApiException catch (e) {
      throw ProductError(e.message);
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteProduct({required String id}) async {
    try {
      return await api.delete(path: '/product/$id');
    } on ApiException catch (e) {
      throw ProductError(e.toString());
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }

  @override
  Future<dynamic> getProducts() async {
    try {
      return await api.getList(path: '/products');
    } on ApiException catch (e) {
      throw ProductError(e.message);
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }

  @override
  Future<dynamic> getTopProducts() async {
    try {
      return await api.getList(path: '/products-top');
    } on ApiException catch (e) {
      throw ProductError(e.message);
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }

  @override
  Future<ApiResponse> createCollectionProduct({required String name}) async {
    try {
      return await api.post(path: '/collection', body: {'name': name});
    } on ApiException catch (e) {
      throw CollectionProductError(e.message);
    } on Exception catch (e) {
      throw CollectionProductError(e.toString());
    }
  }

  @override
  Future<dynamic> getCollectionsProduct() async {
    try {
      return await api.getList(path: '/collections');
    } on ApiException catch (e) {
      throw CollectionProductError(e.message);
    } on Exception catch (e) {
      throw CollectionProductError(e.toString());
    }
  }

  @override
  Future<ApiResponse> updateCollectionProduct({
    required String id,
    required String name,
  }) async {
    try {
      return await api.patch(
        path: '/collection',
        body: {'id': id, 'name': name},
      );
    } on ApiException catch (e) {
      throw CollectionProductError(e.message);
    } on Exception catch (e) {
      throw CollectionProductError(e.toString());
    }
  }

  @override
  Future getProductsByCollection({required String id}) async {
    try {
      return await api.getList(
        path: '/products-by-collection',
        queryParameters: {'id': id},
      );
    } on ApiException catch (e) {
      throw CollectionProductError(e.message);
    } on Exception catch (e) {
      throw CollectionProductError(e.toString());
    }
  }

  @override
  Future<ApiResponse> updateStatusProduct({
    required String id,
    required bool active,
  }) async {
    try {
      return await api.patch(path: '/product-status', body: {
        'id': id,
        'active': active,
      });
    } on ApiException catch (e) {
      throw ProductError(e.message);
    } on Exception catch (e) {
      throw ProductError(e.toString());
    }
  }
}
