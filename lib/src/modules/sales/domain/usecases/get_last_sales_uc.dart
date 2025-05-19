import '../../../../injectable.dart';
import '../../presentation/controllers/sale_controller.dart';
import '../repositories/sale_repository.dart';

abstract interface class GetLastSalesUc {
  Future<void> call();
}

class GetLastSaleUcImpl implements GetLastSalesUc {
  final SaleRepository repository = injector.get();
  final SaleController controller = injector.get();

  @override
  Future<void> call() async {
    controller.setLastSaleLoading(true);
    final result = await repository.getLastSales();
    result.fold(
      (error) => controller.setLastSaleError(error.message),
      (sale) => controller.setLastSale(sale),
    );
    controller.setLastSaleLoading(false);
  }
}