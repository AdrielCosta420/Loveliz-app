import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/widgets/text_form_field_widget.dart';

import '../../../../common/widgets/app_bar_main_widget.dart';
import '../../../../common/widgets/show_adaptive_dialog_widget.dart';
import '../../../../core/providers/app_navigator.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../../domain/uc/create_collection_product_uc.dart';
import '../../domain/uc/get_collections_product_uc.dart';
import '../../domain/uc/update_collection_product_uc.dart';
import '../widgets/card_collection_product_widget.dart';

class CollectionsProductPage extends StatefulWidget {
  const CollectionsProductPage({super.key});

  @override
  State<CollectionsProductPage> createState() => _CollectionsProductPageState();
}

class _CollectionsProductPageState extends State<CollectionsProductPage> {
  final controller = injector.get<CollectionProductController>();
  final getCollectionsProduct = injector.get<GetCollectionsProductUc>();
  final createCollectionProduct = injector.get<CreateCollectionProductUc>();
  final updateCollectionProduct = injector.get<UpdateCollectionProductUc>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCollectionsProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(
        pageName: 'Produtos',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getCollectionsProduct();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // flex: 3,
                    child: TextFormFieldWidget(
                      hintText: 'Buscar coleções...',
                      prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minhas coleções',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      showCustomDialog(
                        context: context,
                        title: 'Criar coleção',

                        content: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nome da coleção',
                                style:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(),
                              ),
                              const SizedBox(height: 8),
                              TextFormFieldWidget(
                                hintText: 'Ex: Coleção de verão',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                                onChanged: controller.collection.setName,
                              ),
                            ],
                          ),
                        ),
                        onPressedConfirm: () {
                          if (controller.formKey.currentState?.validate() ??
                              false) {
                            createCollectionProduct.call();
                          }
                        },
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.plus, size: 12),
                    label: Text(
                      'nova coleção',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListenableBuilder(
                listenable: controller,
                builder: (_, contextBuilder) {
                  return controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing:
                              14, // espaço horizontal entre os itens
                          mainAxisSpacing: 14, // espaço vertical entre os itens
                          mainAxisExtent:
                              MediaQuery.sizeOf(context).height * 0.25,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.collections.length,
                        itemBuilder: (_, index) {
                          final collection = controller.collections[index];

                          return CardCollectionProductWidget(
                            collection: collection,
                            onTap: () {
                              controller.setCollection(collection);
                              AppNavigator.navigateTo(AppRoutes.products);
                            },
                            onEdit: () {
                              showCustomDialog(
                                context: context,
                                title: 'Editar coleção',
                                content: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nome da coleção',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyMedium?.copyWith(),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormFieldWidget(
                                        initialValue: collection.name,
                                        hintText: 'Ex: Coleção de verão',
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo obrigatório';
                                          }
                                          return null;
                                        },
                                        onChanged:
                                            controller.collection.setName,
                                      ),
                                    ],
                                  ),
                                ),
                                onPressedConfirm: () {
                                  controller.collection.setId(collection.id);
                                  if (controller.formKey.currentState
                                          ?.validate() ??
                                      false) {
                                    updateCollectionProduct.call();
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 45,
        child: FloatingActionButton(
          onPressed: () {
            showCustomDialog(
              context: context,
              title: 'Criar coleção',

              content: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nome da coleção',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                    const SizedBox(height: 8),
                    TextFormFieldWidget(
                      hintText: 'Ex: Coleção de verão',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      onChanged: controller.collection.setName,
                    ),
                  ],
                ),
              ),
              onPressedConfirm: () {
                if (controller.formKey.currentState?.validate() ?? false) {
                  createCollectionProduct.call();
                }
              },
            );
          },

          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(FontAwesomeIcons.plus, size: 12),
        ),
      ),
    );
  }
}
