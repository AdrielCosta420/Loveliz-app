import '../../../../injectable.dart';
import '../../ui/controllers/sale_controller.dart';
import '../repositories/sale_repository.dart';

abstract interface class GetLastSaleUc {
  Future<void> call();
}

class GetLastSaleUcImpl implements GetLastSaleUc {
  final SaleRepository repository = injector.get();
  final SaleController controller = injector.get();

  @override
  Future<void> call() async {
    controller.setLastSaleLoading(true);
    final result = await repository.getLastSale();
    result.fold(
      (error) => controller.setLastSaleError(error.message),
      (sale) => controller.setLastSale(sale),
    );
    controller.setLastSaleLoading(false);
  }
}