import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loveliz_app/src/common/widgets/loading_widget.dart';
import 'package:loveliz_app/src/modules/sales/presentation/widgets/register_sale_modal_widget.dart';

import '../../../../common/widgets/app_bar_main_widget.dart';
import '../../../../common/widgets/text_form_field_widget.dart';
import '../../../../core/services/read_qr_code.dart';
import '../../../../injectable.dart';
import '../../domain/usecases/get_sales_uc.dart';
import '../controllers/sale_controller.dart';
import '../widgets/sale_details_modal_widget.dart';
import '../widgets/sale_widget.dart';

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
      appBar: const AppBarMainWidget(pageName: 'Vendas'),
      body: RefreshIndicator(
        onRefresh: () async {
          await getSalesUc();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // flex: 3,
                    child: TextFormFieldWidget(
                      hintText: 'Buscar vendas por produto, cliente ou data',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                      ),
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
                    'Minhas vendas',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
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
                          return const RegisterSaleModalWidget();
                        },
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.plus, size: 12),
                    label: Text(
                      'nova venda',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
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
                          return SaleWidget(
                            sale: sale,
                            onTap: () {
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
                                  return SaleDetailsModalWidget(sale: sale);
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
          onPressed: () async => await readQrCode(),
          child: const Icon(Icons.qr_code_2_rounded),
        ),
      ),
    );
  }
}
