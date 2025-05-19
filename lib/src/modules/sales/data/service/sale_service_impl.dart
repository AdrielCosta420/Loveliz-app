import 'package:loveliz_app/src/common/typedef/typedef.dart';
import 'package:loveliz_app/src/core/api/api_request.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../injectable.dart';
import 'sale_service.dart';

class SaleServiceImpl implements SaleService {
  final api = injector.get<ApiRequest>();

  @override
  Future<List<ApiResponse>> getSales() async {
    try {
      final response = await api.getList(path: '/sales');
      final list = <ApiResponse>[];
      for (var sale in response['sales']) {
        list.add(sale as Map<String, dynamic>);
      }
      return list;
    } on ApiException catch (e) {
      throw ApiException(e.message, e.statusCode);
    } catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }

  @override
  Future<ApiResponse> registerSale({required Map<String, dynamic> sale}) async {
    try {
      return await api.post(path: '/sales', body: sale);
    } on ApiException catch (e) {
      throw ApiException(e.message, e.statusCode);
    } catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
  
  @override
  Future<List<ApiResponse>> getLastSales() async {
    try {
      final response = await api.getList(path: '/sales-last');
      final list = <ApiResponse>[];
      for (var sale in response) {
        list.add(sale as Map<String, dynamic>);
      }
      return list;
    } on ApiException catch (e) {
      throw ApiException(e.message, e.statusCode);
    } catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
  
  @override
  Future<ApiResponse> getSaleById({required String id}) async {
    try {
      return await api.get(path: '/sales/$id');
    } on ApiException catch (e) {
      throw ApiException(e.message, e.statusCode);
    } catch (e) {
      throw ApiException(e.toString(), 500);
    }
  }
}
