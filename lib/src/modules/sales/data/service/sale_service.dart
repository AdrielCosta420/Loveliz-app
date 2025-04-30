import 'package:loveliz_app/src/common/typedef/typedef.dart';

abstract interface class SaleService {
  Future<List<ApiResponse>> getSales();
  Future<ApiResponse> registerSale({required Map<String, dynamic> sale});
  Future<ApiResponse> getLastSale();
  Future<ApiResponse> getSaleById({required String id});
}