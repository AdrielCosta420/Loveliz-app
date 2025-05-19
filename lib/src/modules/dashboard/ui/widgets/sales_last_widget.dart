import 'package:flutter/material.dart';

import '../../../../common/formatters/mask_date.dart';
import '../../../../common/formatters/price_format.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../injectable.dart';
import '../../../sales/domain/usecases/get_last_sales_uc.dart';
import '../../../sales/presentation/controllers/sale_controller.dart';

class SalesLastWidget extends StatefulWidget {
  const SalesLastWidget({super.key});

  @override
  State<SalesLastWidget> createState() => _SalesLastWidgetState();
}

class _SalesLastWidgetState extends State<SalesLastWidget> {
  final controller = injector.get<SaleController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      injector.get<GetLastSalesUc>().call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return controller.isLastSaleLoading
            ? const Center(child: LoadingWidget())
            : controller.lastSale.isEmpty
            ? const Center(child: Text('Nenhuma venda encontrada!'))
            : Card(
              child: ListView.separated(
                padding: const EdgeInsets.all(16.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.lastSale.length,
                separatorBuilder:
                    (_, __) =>
                        const Divider(height: 1, color: Color(0xFFEBEBEB)),
                itemBuilder: (_, index) {
                  final sale = controller.lastSale[index];
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
                            Text.rich(
                              TextSpan(
                                text: sale.product.model,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: ' (${sale.quantity}x)',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              PriceFormat.format(sale.totalPrice),

                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),
                        Text(
                          MaskDate.getRelativeTime(sale.createdAt) ?? '',
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


