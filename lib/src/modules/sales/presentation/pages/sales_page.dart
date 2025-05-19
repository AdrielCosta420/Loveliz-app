import 'package:flutter/material.dart';
import 'package:loveliz_app/src/common/formatters/mask_date.dart';
import 'package:loveliz_app/src/common/formatters/price_format.dart';
import 'package:loveliz_app/src/common/widgets/loading_widget.dart';

import '../../../../common/widgets/app_bar_main_widget.dart';
import '../../../../injectable.dart';
import '../../domain/usecases/get_sales_uc.dart';
import '../controllers/sale_controller.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final controller = injector.get<SaleController>();
  final getSalesUc = injector.get<GetSalesUc>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSalesUc();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(pageName: 'Vendas', title: 'Olá, Alexia!'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vendas',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    // fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    getSalesUc();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            ListenableBuilder(
              listenable: controller,
              builder: (_, __) {
                return controller.isLoading
                    ? const LoadingWidget()
                    : controller.sales.isEmpty
                    ? const Center(child: Text('Nenhuma venda encontrada'))
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.sales.length,
                      itemBuilder: (context, index) {
                        final sale = controller.sales[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sale.product.model,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Text(
                                      PriceFormat.format(sale.totalPrice),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  MaskDate.toAbbreviationForMonth(
                                    sale.createdAt,
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  '${sale.quantity} itens',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
