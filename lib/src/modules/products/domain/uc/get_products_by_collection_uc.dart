import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../repositories/product_repository.dart';

abstract interface class GetProductsByCollectionUc {
  Future<void> call();
}

class GetProductsByCollectionUcImpl implements GetProductsByCollectionUc {
  final repository = injector.get<ProductRepository>();
  final controller = injector.get<CollectionProductController>();

  @override
  Future<void> call() async {
    controller.setLoadingProducts(true);
    final result = await repository.getProductsByCollection(
      id: controller.collection.id,
    );

    result.fold((error) {
      controller.setErrorProducts(error.message);
    }, (success) => controller.setProductsByCollection(success));
    controller.setLoadingProducts(false);
  }
}
