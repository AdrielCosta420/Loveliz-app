import '../../../../common/snackbar/snackbar_custom.dart';
import '../../../../injectable.dart';
import '../../controllers/product_controller.dart';
import '../repositories/product_repository.dart';

import 'get_products_by_collection_uc.dart';

abstract interface class UpdateProductUc {
  Future<void> call();
}

class UpdateProductUcImpl implements UpdateProductUc {
  final ProductRepository repository = injector.get();
  final ProductController controller = injector.get();
  final GetProductsByCollectionUc getProducts = injector.get();

  @override
  Future<void> call() async {
    final response = await repository.updateProduct(
      product: controller.product,
    );

    response.fold((error) => SnackbarCustom.failure('Ocorreu um erro.'), (
      success,
    ) {
      controller.setProduct(success);
      getProducts.call();
      SnackbarCustom.success('Produto atualizado.');
    });
  }
}
