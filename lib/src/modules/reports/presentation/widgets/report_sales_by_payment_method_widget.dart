import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loveliz_app/src/common/enums/payment_method_enum.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../injectable.dart';
import '../controllers/report_controller.dart';

class ReportSalesByPaymentMethodWidget extends StatefulWidget {
  const ReportSalesByPaymentMethodWidget({super.key});

  @override
  State<ReportSalesByPaymentMethodWidget> createState() =>
      _ReportSalesByPaymentMethodWidgetState();
}

class _ReportSalesByPaymentMethodWidgetState
    extends State<ReportSalesByPaymentMethodWidget> {
  final controller = injector.get<ReportController>();
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final chartHeight = size.height * 0.4;

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
              'Formas de Pagamento',
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
            return SizedBox(
              height: chartHeight,
              child:
                  controller.loadingReportSalesByPaymentMethod
                      ? const LoadingWidget()
                      : controller.errorReportSalesByPaymentMethod.isNotEmpty
                      ? Text(
                        'Ocorreu um erro ao mostrar o gráfico de formas de pagamento.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 16,
                        ),
                      )
                      : Column(
                        children: [
                          SizedBox(
                            height: chartHeight * 0.75,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (event, response) {
                                    setState(() {
                                      touchedIndex =
                                          response
                                              ?.touchedSection
                                              ?.touchedSectionIndex;
                                    });
                                  },
                                ),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 2,
                                centerSpaceRadius: 40,
                                sections: List.generate(
                                  controller.reportSalesByPaymentMethod.length,
                                  (index) {
                                    final item =
                                        controller
                                            .reportSalesByPaymentMethod[index];
                                    final isTouched = index == touchedIndex;
                                    final double fontSize = isTouched ? 16 : 9;
                                    final double radius = isTouched ? 75 : 70;
                                    final revenue = item.totalRevenue
                                        .toStringAsFixed(2);

                                    return PieChartSectionData(
                                      value: item.totalRevenue.toDouble(),
                                      title:
                                          isTouched
                                              ? 'R\$ $revenue'
                                              : item.paymentMethod.name,
                                      color: item.paymentMethod.color,
                                      radius: radius,
                                      titleStyle: TextStyle(
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff33384B),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children:
                                controller.reportSalesByPaymentMethod.map((
                                  item,
                                ) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        color: item.paymentMethod.color,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(item.paymentMethod.name),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
            );
          },
        ),
      ],
    );
  }
}
