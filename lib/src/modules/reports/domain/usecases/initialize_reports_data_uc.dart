import '../repositories/report_repository.dart';
import '../../presentation/controllers/report_controller.dart';

import '../../../../injectable.dart';

abstract interface class InitializeReportsDataUc {
  Future<void> call();
}

class InitializeReportsDataUcImpl implements InitializeReportsDataUc {
  final ReportRepository repository = injector.get();
  final ReportController controller = injector.get();
  @override
  Future<void> call() async {
    await Future.wait([
      _getSummaryReportUc(),
      _getSalesByMonthUc(),
      _getSalesByProductUc(),
      _getSalesBySellerUc(),
      _getSalesGrowthUc(),
      _getSalesByPaymentMethodUc(),
    ]);
  }

  Future<void> _getSummaryReportUc() async {
    controller.setLoadingReportSummary(true);
    final response = await repository.getSummaryReport();
    response.fold(
      (error) => controller.setErrorReportSummary(error.message),
      (success) => controller.setReportSummary(success),
    );
    controller.setLoadingReportSummary(false);
  }

  Future<void> _getSalesByMonthUc() async {
    controller.setLoadingReportSalesByMonth(true);
    final response = await repository.getSalesByMonth();
    response.fold(
      (error) => controller.setErrorReportSalesByMonth(error.message),
      (success) => controller.setReportSalesByMonth(success),
    );
    controller.setLoadingReportSalesByMonth(false);
  }

  Future<void> _getSalesByProductUc() async {
    controller.setLoadingReportSalesByProduct(true);
    final response = await repository.getSalesByProduct();
    response.fold(
      (error) => controller.setErrorReportSalesByProduct(error.message),
      (success) => controller.setReportSalesByProduct(success),
    );
    controller.setLoadingReportSalesByProduct(false);
  }

  Future<void> _getSalesBySellerUc() async {
    controller.setLoadingReportSalesBySeller(true);
    final response = await repository.getSalesBySeller();
    response.fold(
      (error) => controller.setErrorReportSalesBySeller(error.message),
      (success) => controller.setReportSalesBySeller(success),
    );
    controller.setLoadingReportSalesBySeller(false);
  }

  Future<void> _getSalesGrowthUc() async {
    controller.setLoadingReportSalesGrowth(true);
    final response = await repository.getSalesGrowth();
    response.fold(
      (error) => controller.setErrorReportSalesGrowth(error.message),
      (success) => controller.setReportSalesGrowth(success),
    );
    controller.setLoadingReportSalesGrowth(false);
  }

  Future<void> _getSalesByPaymentMethodUc() async {
    controller.setLoadingReportSalesByPaymentMethod(true);
    final response = await repository.getSalesByPaymentMethod();
    response.fold(
      (error) => controller.setErrorReportSalesByPaymentMethod(error.message),
      (success) => controller.setReportSalesByPaymentMethod(success),
    );
    controller.setLoadingReportSalesByPaymentMethod(false);
  }
}
