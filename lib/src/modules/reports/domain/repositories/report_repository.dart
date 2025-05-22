import '../models/report_sales_by_payment_method.dart';

import '../../../../common/result/result.dart';
import '../models/report_sales_by_month.dart';
import '../models/report_sales_growth.dart';
import '../models/report_summary.dart';

import '../../errors/report_error.dart';
import '../models/report_sales_by_product.dart';
import '../models/report_sales_by_seller.dart';

abstract interface class ReportRepository {
  Future<Result<ReportError, List<ReportSalesByMonth>>> getSalesByMonth();
  Future<Result<ReportError, List<ReportSalesBySeller>>> getSalesBySeller();
  Future<Result<ReportError, List<ReportSalesByProduct>>> getSalesByProduct();
  Future<Result<ReportError, List<ReportSalesGrowth>>> getSalesGrowth();
  Future<Result<ReportError, ReportSummary>> getSummaryReport();
  Future<Result<ReportError, List<ReportSalesByPaymentMethod>>> getSalesByPaymentMethod();
}