import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/enums/product_sizes_enum.dart';
import '../../../../common/formatters/validator_field.dart';
import '../../../../common/widgets/dropdown_button_form_field_widget.dart';
import '../../../../common/widgets/text_form_field_widget.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../../controllers/product_controller.dart';
import '../../domain/models/collection_product.dart';
import '../../domain/uc/create_product_uc.dart';

class AddProductModalWidget extends StatefulWidget {
  const AddProductModalWidget({super.key});

  @override
  State<AddProductModalWidget> createState() => _AddProductModalWidgetState();
}

class _AddProductModalWidgetState extends State<AddProductModalWidget> {
  final controller = injector.get<CollectionProductController>();
  final productController = injector.get<ProductController>();
  final createProductUC = injector.get<CreateProductUc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.setProduct(
        productController.product
          ..setCollectionId(controller.collection.id)
          ..setCollectionName(controller.collection.name)
          ..setSize(ProductSizesEnum.padrao),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Form(
          key: productController.createProductForm,
          child: Column(
            children: [
              Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
              Row(
                children: [
                  Text(
                    'Adicionar produto',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.circleXmark),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              const Divider(),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormFieldWidget(
                        hintText: 'Nome do modelo',
                        validator: ValidatorField.required,
                        onChanged: (value) {
                          productController.setProduct(
                            productController.product..setModel(value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWidget(
                        hintText: 'Preço do modelo',
                        keyboardType: TextInputType.number,
                        validator: ValidatorField.required,
                        onChanged: (value) {
                          value = value.replaceAll(',', '.');
                          productController.setProduct(
                            productController.product
                              ..setPrice(double.tryParse(value) ?? 0),
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      TextFormFieldWidget(
                        hintText: 'Quantidades do modelo',
                        validator: ValidatorField.required,
                        keyboardType: TextInputType.number,

                        onChanged: (value) {
                          productController.setProduct(
                            productController.product
                              ..setQuantity(int.tryParse(value) ?? 0),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormFieldWidget(
                        hintText: 'Cor do modelo',
                        validator: ValidatorField.required,
                        onChanged: (value) {
                          productController.setProduct(
                            productController.product..setColor(value),
                          );
                          // controller.model = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      ListenableBuilder(
                        listenable: productController,
                        builder: (_, __) {
                          return DropdownButtonFormFieldWidget<
                            ProductSizesEnum
                          >(
                            labelText: 'Tamanho',
                            hintText: 'Selecione um tamanho',
                            value: ProductSizesEnum.padrao,
                            items:
                                ProductSizesEnum.values.map((size) {
                                  return DropdownMenuItem<ProductSizesEnum>(
                                    value: size,
                                    child: Text(size.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              productController.setProduct(
                                productController.product..setSize(value),
                              );
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      ListenableBuilder(
                        listenable: productController,
                        builder: (_, __) {
                          return DropdownButtonFormFieldWidget<
                            CollectionProduct
                          >(
                            labelText: 'Coleção',
                            hintText: 'Selecione uma coleção',
                            value: controller.collection,

                            items:
                                controller.collections.map((collection) {
                                  return DropdownMenuItem<CollectionProduct>(
                                    value: collection,
                                    child: Text(collection.name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              productController.setProduct(
                                productController.product
                                  ..setCollectionId(value?.id ?? '')
                                  ..setCollectionName(value?.name ?? ''),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (productController.createProductForm.currentState
                                    ?.validate() ??
                                false) {
                              createProductUC.call();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancelar',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
