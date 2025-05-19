import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

import '../../../../common/enums/product_sizes_enum.dart';
import '../../../../common/formatters/validator_field.dart';
import '../../../../common/widgets/dropdown_button_form_field_widget.dart';
import '../../../../common/widgets/text_form_field_widget.dart';
import '../../../../injectable.dart';
import '../../controllers/collection_product_controller.dart';
import '../../controllers/product_controller.dart';
import '../../domain/models/collection_product.dart';
import '../../domain/uc/update_product_uc.dart';
import '../../domain/uc/update_status_product_uc.dart';

class UpdateProductModalWidget extends StatefulWidget {
  const UpdateProductModalWidget({super.key});

  @override
  State<UpdateProductModalWidget> createState() =>
      _UpdateProductModalWidgetState();
}

class _UpdateProductModalWidgetState extends State<UpdateProductModalWidget> {
  final controller = injector.get<CollectionProductController>();
  final productController = injector.get<ProductController>();
  final updateProductUc = injector.get<UpdateProductUc>();
  final updateStatusProductUc = injector.get<UpdateStatusProductUc>();
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
          key: productController.updateProductForm,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Editar produto',
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
                      ListenableBuilder(
                        listenable: productController,
                        builder: (_, __) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Status do produto',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 8),
                                AnimatedToggleSwitch<bool>.dual(
                                  current: productController.product.active,
                                  first: false,
                                  second: true,

                                  borderWidth: 5.0,
                                  height: 40,

                                  onChanged: (value) {
                                    productController.setProduct(
                                      productController.product
                                        ..setActive(value),
                                    );
                                    updateStatusProductUc.call();
                                  },

                                  iconBuilder:
                                      (value) =>
                                          value
                                              ? const Icon(
                                                Icons.check_circle,
                                                color: Colors.white,
                                              )
                                              : const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                              ),
                                  textBuilder:
                                      (value) =>
                                          value
                                              ? const Center(
                                                child: Text(
                                                  'Ativo',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                              : const Center(
                                                child: Text(
                                                  'Inativo',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      TextFormFieldWidget(
                        initialValue: productController.product.model,
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
                        initialValue:
                            productController.product.price.toString(),
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
                        initialValue:
                            productController.product.quantity.toString(),
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
                        initialValue: productController.product.color,
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
                            value: productController.product.size,
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
                            value: controller.collections.firstWhere(
                              (collection) =>
                                  collection.name ==
                                  productController.product.collectionName,
                            ),
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
                            if (productController.updateProductForm.currentState
                                    ?.validate() ??
                                false) {
                              updateProductUc.call();
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
