import 'package:flutter/material.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../injectable.dart';
import '../controllers/report_controller.dart';

class ReportSalesBySellerWidget extends StatefulWidget {
  const ReportSalesBySellerWidget({super.key});

  @override
  State<ReportSalesBySellerWidget> createState() =>
      _ReportSalesBySellerWidgetState();
}

class _ReportSalesBySellerWidgetState extends State<ReportSalesBySellerWidget> {
  final controller = injector.get<ReportController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Vendas por Vendedores',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        ListenableBuilder(
          listenable: controller,

          builder: (_, __) {
            return controller.loadingReportSalesBySeller
                ? const LoadingWidget()
                : controller.errorReportSalesBySeller.isNotEmpty
                ? Text(
                  'Ocorreu um erro ao mostrar os Vendedores.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 16,
                  ),
                )
                : ListView.builder(
                  itemCount: controller.reportSalesBySeller.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    final seller = controller.reportSalesBySeller[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F9FB),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: const Offset(0, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.black87,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  seller.sellerName,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: Colors.greenAccent.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'R\$ ${seller.sum.totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: Colors.blueAccent.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${seller.count.totalCount} vendas',
                                style: TextStyle(
                                  color: Colors.blueAccent.shade700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
          },
        ),
      ],
    );
  }
}
