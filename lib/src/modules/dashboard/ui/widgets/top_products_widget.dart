import 'package:flutter/material.dart';
import '../../../products/controllers/product_controller.dart';
import '../../../products/domain/uc/get_top_products_uc.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../injectable.dart';

class TopProductsWidget extends StatefulWidget {
  const TopProductsWidget({super.key});

  @override
  State<TopProductsWidget> createState() => _TopProductsWidgetState();
}

class _TopProductsWidgetState extends State<TopProductsWidget> {
  final controller = injector.get<ProductController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      injector.get<GetTopProductsUc>().call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return controller.isLoadingTopProducts
            ? const Center(child: LoadingWidget())
            : controller.topProducts.isEmpty
            ? const Center(child: Text('Ainda não há registros.'))
            : Card(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.topProducts.length,
                separatorBuilder:
                    (_, __) =>
                        const Divider(height: 1, color: Color(0xFFEBEBEB)),
                itemBuilder: (_, index) {
                  final topProduct = controller.topProducts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              topProduct.model,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),

                            Text(
                              '${topProduct.totalSold} unidades',

                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Text(
                          topProduct.collectionName,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
