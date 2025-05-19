import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loveliz_app/src/common/enums/payment_method_enum.dart';
import 'package:loveliz_app/src/modules/products/domain/uc/get_products_uc.dart';
import '../../../../common/formatters/validator_field.dart';
import '../../../../common/widgets/dropdown_button_form_field_widget.dart';
import '../../../../common/widgets/text_form_field_widget.dart';
import '../../../../injectable.dart';
import '../../../products/controllers/product_controller.dart';
import '../../../products/domain/models/product.dart';
import '../../../user/presentation/controllers/user_controller.dart';
import '../../domain/usecases/register_sale_uc.dart';
import '../controllers/sale_controller.dart';
import 'quantity_sale_box_widget.dart';

class RegisterSaleModalWidget extends StatefulWidget {
  const RegisterSaleModalWidget({super.key});

  @override
  State<RegisterSaleModalWidget> createState() =>
      _RegisterSaleModalWidgetState();
}

class _RegisterSaleModalWidgetState extends State<RegisterSaleModalWidget> {
  final getProducts = injector.get<GetProductsUc>();
  final registerSaleUc = injector.get<RegisterSaleUc>();
  final saleController = injector.get<SaleController>();
  final controller = injector.get<ProductController>();
  final userController = injector.get<UserController>();

  final totalPriceController = TextEditingController();
  final clientNameController = TextEditingController();
  final quantityController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts.call();
      saleController.setSale(
        saleController.sale.copyWith(
          paymentMethod: PaymentMethodEnum.pix,
          sellerId: userController.user.id,
          sellerName: userController.user.name,
          quantity: int.tryParse(quantityController.text),
        ),
      );
    });
  }

  @override
  void dispose() {
    totalPriceController.dispose();
    clientNameController.dispose();
    quantityController.dispose();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      saleController.resetSale();
      controller.resetProduct();
    });

    super.dispose();
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
        child: SingleChildScrollView(
          child: Form(
            key: saleController.registerSaleFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Nova venda',
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
                ListenableBuilder(
                  listenable: controller,
                  builder: (_, __) {
                    return DropdownButtonFormFieldWidget<Product>(
                      validator:
                          (value) => ValidatorField.required(value?.model),
                      onChanged: (value) {
                        saleController.setSale(
                          saleController.sale.copyWith(productId: value?.id),
                        );

                        controller.setProduct(value ??= Product.empty());
                      },
                      labelText: 'Modelo',
                      hintText: 'Selecione um modelo',
                      items:
                          controller.products
                              .map(
                                (product) => DropdownMenuItem(
                                  value: product,
                                  child: Text(product.model),
                                ),
                              )
                              .toList(),
                    );
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormFieldWidget<PaymentMethodEnum>(
                  value: PaymentMethodEnum.pix,
                  labelText: 'Forma de pagamento',
                  hintText: 'Selecione uma forma de pagamento',
                  validator: (value) => ValidatorField.required(value?.name),
                  onChanged:
                      (value) => saleController.setSale(
                        saleController.sale.copyWith(paymentMethod: value),
                      ),
                  items:
                      PaymentMethodEnum.values
                          .map(
                            (paymentMethod) => DropdownMenuItem(
                              value: paymentMethod,
                              child: Text(paymentMethod.name),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 16),

                TextFormFieldWidget(
                  hintText: 'Digite o nome do cliente',
                  onChanged:
                      (value) => saleController.setSale(
                        saleController.sale.copyWith(clientName: value),
                      ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Informe a quantidade',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      highlightColor: Theme.of(context).colorScheme.primary,
                      onPressed: _decreaseQuantity,
                      icon: const Icon(Icons.remove, color: Color(0xff33384B)),
                    ),

                    QuantitySaleBoxWidget(
                      quantityController: quantityController,
                    ),
                    IconButton(
                      highlightColor: Theme.of(context).colorScheme.primary,
                      onPressed: _increaseQuantity,
                      icon: const Icon(Icons.add, color: Color(0xff33384B)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: totalPriceController,
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                    },
                    cursorHeight: 15,
                    style: GoogleFonts.openSans(
                      color: const Color(0xff33384B),
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged:
                        (value) => saleController.setSale(
                          saleController.sale.copyWith(
                            totalPrice: double.tryParse(value),
                          ),
                        ),
                    validator: ValidatorField.required,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                        top: 12,
                        bottom: 8,
                        left: 16,
                        right: 16,
                      ),
                      suffixStyle: TextStyle(
                        color: Color(0xff33384B),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xffB2BCC9),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      hintText: 'Valor da venda',
                      filled: true,
                      fillColor: Color(0xffFAFAFC),
                      errorStyle: TextStyle(height: 0, fontSize: 0),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (saleController.registerSaleFormKey.currentState
                              ?.validate() ??
                          false) {
                        registerSaleUc.call();
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Registrar venda'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateTotalPrice() {
    final quantity = int.tryParse(quantityController.text) ?? 1;

    if (controller.product.id.isNotEmpty) {
      final total = controller.product.price * quantity;

      totalPriceController.text = total.toStringAsFixed(2);
      saleController.setSale(
        saleController.sale.copyWith(totalPrice: total, quantity: quantity),
      );
    }
  }

  void _increaseQuantity() {
    final current = int.tryParse(quantityController.text) ?? 1;

    quantityController.text = (current + 1).toString();
    saleController.setSale(
      saleController.sale.copyWith(
        quantity: int.tryParse(quantityController.text),
      ),
    );
    _updateTotalPrice();
  }

  void _decreaseQuantity() {
    final current = int.tryParse(quantityController.text) ?? 1;
    if (current > 1) {
      quantityController.text = (current - 1).toString();
      saleController.setSale(
        saleController.sale.copyWith(
          quantity: int.tryParse(quantityController.text),
        ),
      );
      _updateTotalPrice();
    }
  }
}
