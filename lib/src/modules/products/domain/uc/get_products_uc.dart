import 'dart:developer';

import '../../../../injectable.dart';
import '../../controllers/product_controller.dart';
import '../../repositories/product_repository.dart';

abstract interface class GetProductsUc {
  Future<void> call();
}

class GetProductsUcImpl implements GetProductsUc {
  final _repository = injector.get<ProductRepository>();
  final _controller = injector.get<ProductController>();

  @override
  Future<void> call() async {
    _controller.setLoading(true);
    final result = await _repository.getProducts();
    result.fold(
      (error) =>log(error.toString()),
      (success) => _controller.setProducts(success),
    );
    _controller.setLoading(false);

  }
}
