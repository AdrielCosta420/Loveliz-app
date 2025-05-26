import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loveliz_app/src/common/widgets/loading_widget.dart';

import '../../../../injectable.dart';
import '../controllers/report_controller.dart';

class ReportSalesByProductWidget extends StatefulWidget {
  const ReportSalesByProductWidget({super.key});

  @override
  State<ReportSalesByProductWidget> createState() =>
      _ReportSalesByProductWidgetState();
}

class _ReportSalesByProductWidgetState
    extends State<ReportSalesByProductWidget> {
  final controller = injector.get<ReportController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              'Vendas por Produtos',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListenableBuilder(
          listenable: controller,
          builder: (_, __) {
            final maxYValue = controller.reportSalesByProduct
                .map((e) => e.totalSold.toDouble())
                .reduce((a, b) => a > b ? a : b);
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child:
                  controller.loadingReportSalesByProduct
                      ? const LoadingWidget()
                      : controller.errorReportSalesByProduct.isNotEmpty
                      ? Text(
                        'Ocorreu um erro ao mostrar o gráfico de vendas por Produtos.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 16,
                        ),
                      )
                      : BarChart(
                        BarChartData(
                          maxY: maxYValue * 1.15,
                          backgroundColor: const Color(0xFF545675),
                          gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            horizontalInterval: 1,
                            verticalInterval: 1,
                            getDrawingHorizontalLine: (value) {
                              return const FlLine(
                                color: Color(0xff808080),
                                strokeWidth: 0.5,
                              );
                            },
                          ),
                          barGroups: List.generate(
                            controller.reportSalesByProduct.length,
                            (index) {
                              return BarChartGroupData(
                                x: index,
                                barRods: [
                                  BarChartRodData(
                                    toY:
                                        (controller
                                                .reportSalesByProduct[index]
                                                .totalSold)
                                            .toDouble(),
                                    width: 15,

                                    color: const Color(0xffffa4c4),
                                  ),
                                ],
                              );
                            },
                          ),

                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                                getTitlesWidget:
                                    (value, meta) => Text(
                                      '${value.toInt().toString()}x',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                      ),
                                    ),
                              ),
                              // axisNameSize: 0.5,
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 32,
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  int index = value.toInt();
                                  return Text(
                                    controller
                                        .reportSalesByProduct[index]
                                        .productName,
                                    style: const TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xffFFFFFF),
                              width: 0.5,
                            ),
                          ),

                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (group) => Colors.black,

                              tooltipBorderRadius: BorderRadius.circular(8),

                              getTooltipItem: (
                                group,
                                groupIndex,
                                rod,
                                rodIndex,
                              ) {
                                return BarTooltipItem(
                                  '${controller.reportSalesByProduct[group.x].productName}: ${rod.toY.toInt()}',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
            );
          },
        ),
      ],
    );
  }
}
