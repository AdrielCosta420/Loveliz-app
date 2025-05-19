import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../common/widgets/app_bar_secondary_widget.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../../controllers/product_controller.dart';
import '../../domain/uc/get_products_by_collection_uc.dart';
import '../widgets/add_product_modal_widget.dart';
import '../widgets/card_product_widget.dart';
import '../widgets/update_product_modal_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = injector.get<CollectionProductController>();
  final getProductsByCollection = injector.get<GetProductsByCollectionUc>();
  final productController = injector.get<ProductController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProductsByCollection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSecondaryWidget(
        title: 'Voltar',
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.plus, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                builder: (_) {
                  return const AddProductModalWidget();
                },
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (_, __) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child:
                controller.isLoadingProducts
                    ? Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.25,
                      ),
                      child: const LoadingWidget(),
                    )
                    : controller.errorProducts.isNotEmpty
                    ? SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.25,
                      child: Text(
                        controller.errorProducts,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                      ),
                    )
                    : controller.productsByCollection.isEmpty
                    ? Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.25,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.boxOpen,
                              size: 60,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                text: 'Não há produtos na coleção:\n',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: controller.collection.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Produtos',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                mainAxisExtent:
                                    MediaQuery.sizeOf(context).height * 0.3,
                              ),
                          itemCount: controller.productsByCollection.length,
                          itemBuilder: (context, index) {
                            final product =
                                controller.productsByCollection[index];
                            return CardProductWidget(
                              product: product,
                              onTap: () {
                                productController.setProduct(product);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,

                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(32),
                                    ),
                                  ),

                                  builder: (_) {
                                    return const UpdateProductModalWidget();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),

              builder: (_) {
                return const AddProductModalWidget();
              },
            ),
        backgroundColor: Theme.of(context).primaryColor,
        label: const Text(
          'Novo produto',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(FontAwesomeIcons.plus, size: 20),
      ),
    );
  }
}
