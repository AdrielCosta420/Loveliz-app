import '../../../../common/snackbar/snackbar_custom.dart';
import '../models/product.dart';
import 'get_products_by_collection_uc.dart';

import '../../controllers/product_controller.dart';

import '../../../../injectable.dart';
import '../repositories/product_repository.dart';

abstract interface class CreateProductUc {
  Future<void> call();
}

class CreateProductUcImpl implements CreateProductUc {
  final ProductRepository repository = injector.get();
  final ProductController controller = injector.get();
  final GetProductsByCollectionUc getProducts = injector.get();
  @override
  Future<void> call() async {
    final response = await repository.createProduct(
      product: controller.product,
    );

    response.fold((error) => SnackbarCustom.failure('Ocorreu um erro.'), (
      success,
    ) {
      getProducts.call();
      SnackbarCustom.success('Produto criado.');
      controller.setProduct(Product.empty());

    });
  }
}
