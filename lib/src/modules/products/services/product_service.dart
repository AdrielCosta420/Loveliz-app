import 'package:loveliz_app/src/common/typedef/typedef.dart';
import 'package:loveliz_app/src/core/api/api_exception.dart';
import 'package:loveliz_app/src/modules/products/domain/errors/product_error.dart';
import 'package:loveliz_app/src/modules/products/domain/models/product.dart';

import '../../../core/api/api_request.dart';
import '../../../injectable.dart';

abstract interface class ProductService {
  Future<dynamic> getProducts();
  Future<ApiResponse> createProduct({required Product product});
  Future<ApiResponse> deleteProduct({required String id});
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
}
