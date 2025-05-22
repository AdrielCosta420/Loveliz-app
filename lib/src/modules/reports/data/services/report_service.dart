import '../../../../common/typedef/typedef.dart';

abstract interface class ReportService {
  Future<ApiResponse> getSummaryReport();
  Future<dynamic> getSalesByMonth();
  Future<dynamic> getSalesByProduct();
  Future<dynamic> getSalesGrowth();
  Future<dynamic> getSalesBySeller();
  Future<dynamic> getSalesByPaymentMethod();
}
