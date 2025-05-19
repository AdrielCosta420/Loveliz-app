import 'package:flutter/material.dart';
import 'package:loveliz_app/src/injectable.dart';
import '../../../sales/domain/usecases/get_sales_uc.dart';
import '../../../sales/presentation/controllers/sale_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../common/formatters/price_format.dart';
import '../../../../common/formatters/mask_date.dart';
import '../../../../common/widgets/app_bar_main_widget.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../../core/services/read_qr_code.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../sales/presentation/widgets/register_sale_modal_widget.dart';
import '../widgets/sales_last_widget.dart';
import '../widgets/top_products_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final controller = injector.get<SaleController>();
  final auth = injector.get<AuthController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      injector.get<GetSalesUc>().call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(pageName: 'Dashboard'),
      body: RefreshIndicator(
        onRefresh: () async {
          await injector.get<GetSalesUc>().call();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: 'Hoje ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                  children: [
                    TextSpan(
                      text: MaskDate.toAbbreviationForMonth(DateTime.now()),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (_, _) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:
                                controller.isLoading
                                    ? const LoadingWidget()
                                    : Column(
                                      children: [
                                        Text(
                                          'Vendas total: ',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                        Text(
                                          '${controller.totalSales}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListenableBuilder(
                      listenable: controller,
                      builder: (_, _) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child:
                                controller.isLoading
                                    ? const LoadingWidget()
                                    : Column(
                                      children: [
                                        Text(
                                          'Total vendido:',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                        Text(
                                          PriceFormat.format(
                                            controller.totalPrice,
                                          ),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                  ),
                  onPressed: () async => await readQrCode(),
                  label: Text(
                    'Escanear QR Code',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.qr_code_2_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
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
                  label: Text(
                    'Registrar nova Venda',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Produtos mais Vendidos',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const TopProductsWidget(),
              const SizedBox(height: 24),
              Text(
                'Vendas Recentes',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              const SalesLastWidget(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
