import 'package:flutter/material.dart';
import '../../../../common/widgets/app_bar_secondary_widget.dart';
import '../../../../common/widgets/custom_dropdown_search_widget.dart';
import '../../../../common/widgets/text_form_field_widget.dart';
import '../widgets/quantity_sale_box_widget.dart';

class RegisterSalePage extends StatefulWidget {
  const RegisterSalePage({super.key});

  @override
  State<RegisterSalePage> createState() => _RegisterSalePageState();
}

class _RegisterSalePageState extends State<RegisterSalePage> {
  String? selectedPaymentMethod = 'Pix';
  final totalPriceController = TextEditingController();
  final clientNameController = TextEditingController();
  final quantityController = TextEditingController(text: '1');

  void _increaseQuantity() {
    final current = int.tryParse(quantityController.text) ?? 1;
    setState(() {
      quantityController.text = (current + 1).toString();
    });
  }

  void _decreaseQuantity() {
    final current = int.tryParse(quantityController.text) ?? 1;
    if (current > 1) {
      setState(() {
        quantityController.text = (current - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarSecondaryWidget(title: 'Voltar'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modelo da venda
            Text(
              'Modelo da venda',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            CustomDropdownSearch(
              items:
                  (l, s) => [
                    'Produto 1',
                    'Produto 2',
                    'Produto 3',
                    'Produto 4',
                    'Produto 5',
                  ],
              onChanged: (p0) {},
            ),
            const SizedBox(height: 16),

            // Nome do cliente
            Text(
              'Nome do cliente',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            TextFormFieldWidget(
              hintText: 'Digite o nome do cliente',
              onChanged: (p0) {},
            ),
            const SizedBox(height: 16),

            // Quantidade com botão + e -
            Text('Quantidade', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  highlightColor: Theme.of(context).colorScheme.primary,
                  onPressed: _decreaseQuantity,
                  icon: const Icon(Icons.remove, color: Color(0xff33384B)),
                ),

                QuantitySaleBoxWidget(),
                IconButton(
                  highlightColor: Theme.of(context).colorScheme.primary,
                  onPressed: _increaseQuantity,
                  icon: const Icon(Icons.add, color: Color(0xff33384B)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Preço total
            Text('Preço total', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            TextFormFieldWidget(
              hintText: 'R\$ 0,00',
              keyboardType: TextInputType.number,
              onChanged: (p0) {},
            ),
            const SizedBox(height: 16),
            TextFormField(),
            // Forma de pagamento
            Text(
              'Forma de pagamento',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Column(
              children:
                  ['Pix', 'Dinheiro', 'Cartão'].map((method) {
                    return RadioListTile<String>(
                      title: Text(method),
                      value: method,
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),

            // Botão de registrar venda
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
