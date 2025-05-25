import 'package:flutter/material.dart';
import 'package:loveliz_app/src/common/widgets/app_bar_main_widget.dart';

import '../../../../injectable.dart';
import '../../../agent_ai/presentation/widgets/assistant_fab_widget.dart';
import '../../domain/usecases/initialize_reports_data_uc.dart';
import '../controllers/report_controller.dart';
import '../widgets/report_sales_by_month_widget.dart';
import '../widgets/report_sales_by_payment_method_widget.dart';
import '../widgets/report_sales_by_product_widget.dart';
import '../widgets/report_sales_by_seller_widget.dart';
import '../widgets/report_summary_widget.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final initializeReportsDataUc = injector.get<InitializeReportsDataUc>();
  final controller = injector.get<ReportController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeReportsDataUc.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMainWidget(pageName: 'Relatórios'),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    ListenableBuilder(
                      listenable: controller,
                      builder: (_, __) {
                        return ReportSummaryWidget(
                          title: 'Total de Vendas',
                          value: '${controller.reportSummary.totalSales}',
                          icon: Icons.shopping_cart_outlined,
                          color: Colors.blueAccent.shade700,
                          isLoading: controller.loadingReportSummary,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ListenableBuilder(
                      listenable: controller,
                      builder: (_, __) {
                        return ReportSummaryWidget(
                          title: 'Receita Total',
                          value:
                              'R\$ ${controller.reportSummary.totalRevenue.toStringAsFixed(2)}',
                          icon: Icons.monetization_on_outlined,
                          color: Colors.greenAccent.shade700,
                          isLoading: controller.loadingReportSummary,
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    const ReportSalesByMonthWidget(),
                    const SizedBox(height: 28),
                    const ReportSalesByPaymentMethodWidget(),
                    const SizedBox(height: 28),
                    const ReportSalesByProductWidget(),
                    const SizedBox(height: 20),
                    const ReportSalesBySellerWidget(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          const AssistantFabWidget(),
        ],
      ),
    );
  }
}
