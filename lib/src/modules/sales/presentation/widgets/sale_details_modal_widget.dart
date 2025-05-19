import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/formatters/mask_date.dart';
import '../../../../common/formatters/price_format.dart';
import '../../domain/models/sale.dart';
import 'row_item_sale_widget.dart';

class SaleDetailsModalWidget extends StatelessWidget {
  final Sale sale;
  const SaleDetailsModalWidget({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: SingleChildScrollView(
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
                  'Detalhes da Venda',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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
            RowItemSaleWidget(label: 'Código da venda', value: sale.saleCode),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Coleção',
              value: sale.product?.collectionName ?? 'Não informado',
            ),
            const SizedBox(height: 8),
            RowItemSaleWidget(label: 'Modelo', value: sale.product?.model ?? ''),
            const SizedBox(height: 8),
            RowItemSaleWidget(label: 'Quantidade', value: '${sale.quantity}'),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Preço unitário',
              value: PriceFormat.format(sale.product?.price ?? 0),
            ),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Preço total',
              value: PriceFormat.format(sale.totalPrice),
            ),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Forma de pagamento',
              value: sale.paymentMethod?.name ?? 'Não informado',
            ),
            const SizedBox(height: 8),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Cliente',
              value:
                  sale.clientName?.isNotEmpty == true
                      ? sale.clientName!
                      : 'Não informado',
            ),
            const SizedBox(height: 8),

            RowItemSaleWidget(label: 'Vendedor', value: sale.sellerName),
            const SizedBox(height: 8),
            RowItemSaleWidget(
              label: 'Data da venda',
              value: MaskDate.toAbbreviationForMonth(sale.createdAt),
            ),
          ],
        ),
      ),
    );
  }
}
