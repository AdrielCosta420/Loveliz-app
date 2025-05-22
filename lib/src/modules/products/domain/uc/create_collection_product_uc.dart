import '../repositories/product_repository.dart';
import 'get_collections_product_uc.dart';

import '../../../../common/snackbar/snackbar_custom.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';

abstract interface class CreateCollectionProductUc {
  Future<void> call();
}

class CreateCollectionProductUcImpl implements CreateCollectionProductUc {
  final controller = injector.get<CollectionProductController>();
  final repository = injector.get<ProductRepository>();
  final getCollectionsProductUc = injector.get<GetCollectionsProductUc>();
  @override
  Future<void> call() async {

    final response = await repository.createCollectionProduct(
      name: controller.collection.name,
    );

    response.fold((error) => SnackbarCustom.failure(error.message), (success) {
      SnackbarCustom.success('Coleção criada.', title: 'Sucesso');
      getCollectionsProductUc.call();
    });

 
  }
}
