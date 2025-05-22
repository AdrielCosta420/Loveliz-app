import 'get_collections_product_uc.dart';

import '../../../../common/snackbar/snackbar_custom.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../repositories/product_repository.dart';

abstract interface class UpdateCollectionProductUc {
  Future<void> call();
}

class UpdateCollectionProductUcImpl implements UpdateCollectionProductUc {
  final controller = injector.get<CollectionProductController>();
  final repository = injector.get<ProductRepository>();
  final getCollectionsProductUc = injector.get<GetCollectionsProductUc>();

  @override
  Future<void> call() async {
    final response = await repository.updateCollectionProduct(
      id: controller.collection.id,
      name: controller.collection.name,
    );

    response.fold((error) => SnackbarCustom.failure(error.message), (success) {
      SnackbarCustom.success('Coleção atualizada.', title: 'Sucesso');
      getCollectionsProductUc.call();
    });
  }
}
