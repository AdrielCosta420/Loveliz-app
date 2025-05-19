import 'dart:developer';

import '../../../../common/snackbar/snackbar_custom.dart';

import '../../../../injectable.dart';
import '../../presentation/controllers/sale_controller.dart';
import '../repositories/sale_repository.dart';
import 'get_sales_uc.dart';

abstract interface class RegisterSaleUc {
  Future<void> call();
}

class RegisterSaleUcImpl implements RegisterSaleUc {
  final repository = injector.get<SaleRepository>();
  final controller = injector.get<SaleController>();
  final getSalesUc = injector.get<GetSalesUc>();
  @override
  Future<void> call() async {
    controller.setLoading(true);
    final result = await repository.registerSale(sale: controller.sale);
    result.fold(
      (error) {
        log(error.message);
        SnackbarCustom.failure('Ocorreu um erro ao registrar venda.');
      },
      (success) {
        controller.setSale(success);
        SnackbarCustom.success('Venda registrada com sucesso');
        getSalesUc.call();
      },
    );
    controller.setLoading(false);
  }
}
