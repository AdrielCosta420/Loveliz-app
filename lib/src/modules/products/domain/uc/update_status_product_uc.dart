import '../../../../common/snackbar/snackbar_custom.dart';
import '../../../../injectable.dart';
import '../../controllers/product_controller.dart';
import '../repositories/product_repository.dart';

abstract interface class UpdateStatusProductUc {
  Future<void> call();
}

class UpdateStatusProductUcImpl implements UpdateStatusProductUc {
  final ProductRepository repository = injector.get();
  final ProductController controller = injector.get();

  @override
  Future<void> call() async {
    final response = await repository.updateStatusProduct(
      id: controller.product.id,
      active: !controller.product.active,
    );

    response.fold(
      (error) => SnackbarCustom.failure('Ocorreu um erro.'),
      (success) => SnackbarCustom.success(success),
    );
  }
}
