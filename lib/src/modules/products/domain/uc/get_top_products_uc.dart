import '../../../../injectable.dart';
import '../../controllers/product_controller.dart';
import '../../repositories/product_repository.dart';

abstract interface class GetTopProductsUc {
  Future<void> call();
}

class GetTopProductsUcImpl implements GetTopProductsUc {
  final ProductRepository repository = injector.get<ProductRepository>();
  final controller = injector.get<ProductController>();

  @override
  Future<void> call() async {
    controller.setLoadingTopProducts(true);
    final result = await repository.getTopProducts();
    result.fold(
      (error) => controller.setErrorMessageTopProducts(error.message),
      (success) => controller.setTopProducts(success),
    );
    controller.setLoadingTopProducts(false);
  }
}
