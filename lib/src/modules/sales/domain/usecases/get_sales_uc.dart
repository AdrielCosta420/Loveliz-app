import 'dart:developer';


import '../../../../injectable.dart';
import '../../ui/controllers/sale_controller.dart';
import '../repositories/sale_repository.dart';

abstract interface class GetSalesUc {
  Future<void> call();
}

class GetSalesUcImpl implements GetSalesUc {
  final SaleRepository repository = injector.get();
  final SaleController controller = injector.get();

  @override
  Future<void> call() async {
    controller.setLoading(true);
    final result = await repository.getSales();
    result.fold(
      (error) => log(error.message),
      (sales) => controller.setSales(sales),
    );
    controller.setLoading(false);
  }
}
