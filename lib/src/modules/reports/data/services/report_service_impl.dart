import '../../../../common/typedef/typedef.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../injectable.dart';
import '../../errors/report_error.dart';
import 'report_service.dart';
import '../../../../core/api/api_request.dart';

class ReportServiceImpl implements ReportService {
  final ApiRequest api = injector.get();
  @override
  Future<dynamic> getSalesByMonth() async {
    try {
      final response = await api.getList(path: '/reports/sales-by-month');
      return response;
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }

  @override
  Future<dynamic> getSalesByProduct() async {
    try {
      final response = await api.getList(path: '/reports/sales-by-product');
      return response;
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }

  @override
  Future<dynamic> getSalesBySeller() async {
    try {
      final response = await api.getList(path: '/reports/sales-by-seller');
      return response;
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }

  @override
  Future<dynamic> getSalesGrowth() async {
    try {
      final response = await api.getList(path: '/reports/sales-growth');
      return response;
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }

  @override
  Future<ApiResponse> getSummaryReport() async {
    try {
      final response = await api.get(path: '/reports/summary');
      return response;
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }

  @override
  Future getSalesByPaymentMethod() async {
    try {
      return await api.getList(path: '/reports/sales-by-payment-method');
    } on ApiException catch (e) {
      throw ReportError(e.message, e.statusCode);
    } catch (e) {
      throw ReportError(e.toString(), null);
    }
  }
}
