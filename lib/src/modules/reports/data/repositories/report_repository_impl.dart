import 'package:loveliz_app/src/modules/reports/domain/models/report_sales_by_payment_method.dart';
import 'package:loveliz_app/src/modules/reports/domain/models/report_sales_growth.dart';

import '../../../../common/result/result.dart';

import '../../../../injectable.dart';
import '../../domain/models/report_sales_by_month.dart';

import '../../domain/models/report_sales_by_product.dart';

import '../../domain/models/report_sales_by_seller.dart';

import '../../domain/models/report_summary.dart';

import '../../errors/report_error.dart';

import '../../domain/repositories/report_repository.dart';
import '../services/report_service.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportService service = injector.get();

  @override
  Future<Result<ReportError, ReportSummary>> getSummaryReport() async {
    try {
      return Result.success(
        ReportSummary.fromMap(await service.getSummaryReport()),
      );
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }

  @override
  Future<Result<ReportError, List<ReportSalesByMonth>>>
  getSalesByMonth() async {
    try {
      final response = await service.getSalesByMonth();
      final List<ReportSalesByMonth> list = [];
      for (var element in response) {
        list.add(ReportSalesByMonth.fromMap(element));
      }
      return Result.success(list);
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }

  @override
  Future<Result<ReportError, List<ReportSalesByProduct>>>
  getSalesByProduct() async {
    try {
      final response = await service.getSalesByProduct();
      final List<ReportSalesByProduct> list = [];
      for (var element in response) {
        list.add(ReportSalesByProduct.fromMap(element));
      }
      return Result.success(list);
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }

  @override
  Future<Result<ReportError, List<ReportSalesBySeller>>>
  getSalesBySeller() async {
    try {
      final response = await service.getSalesBySeller();
      final List<ReportSalesBySeller> list = [];
      for (var element in response) {
        list.add(ReportSalesBySeller.fromMap(element));
      }
      return Result.success(
        list,
      );
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }

  @override
  Future<Result<ReportError, List<ReportSalesGrowth>>> getSalesGrowth() async {
    try {
      final response = await service.getSalesGrowth();
      final List<ReportSalesGrowth> list = [];
      for (var element in response) {
        list.add(ReportSalesGrowth.fromMap(element));
      }
      return Result.success(list);
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }

  @override
  Future<Result<ReportError, List<ReportSalesByPaymentMethod>>> getSalesByPaymentMethod() async {
    try {
      final response = await service.getSalesByPaymentMethod();
      final List<ReportSalesByPaymentMethod> list = [];
      for (var element in response) {
        list.add(ReportSalesByPaymentMethod.fromMap(element));
      }
      return Result.success(list);
    } on ReportError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(ReportError(e.toString(), null));
    }
  }
}
