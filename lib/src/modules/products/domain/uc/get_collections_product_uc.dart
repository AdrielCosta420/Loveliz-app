import '../../controllers/collection_product_controller.dart';

import '../../../../injectable.dart';
import '../repositories/product_repository.dart';

abstract interface class GetCollectionsProductUc {
  Future<void> call();
}

class GetCollectionsProductUcImpl implements GetCollectionsProductUc {
  final repository = injector.get<ProductRepository>();
  final controller = injector.get<CollectionProductController>();

  @override
  Future<void> call() async {
    controller.setLoading(true);
    final response = await repository.getCollectionsProduct();
    response.fold(
      (error) => controller.setErrorCollections(error.message),
      (success) => controller.setCollections(success),
    );
    controller.setLoading(false);
  }
}
