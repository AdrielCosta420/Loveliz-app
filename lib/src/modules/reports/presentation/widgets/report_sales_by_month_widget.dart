import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/loading_widget.dart';
import '../../../../injectable.dart';
import '../controllers/report_controller.dart';

class ReportSalesByMonthWidget extends StatefulWidget {
  const ReportSalesByMonthWidget({super.key});

  @override
  State<ReportSalesByMonthWidget> createState() =>
      _ReportSalesByMonthWidgetState();
}

class _ReportSalesByMonthWidgetState extends State<ReportSalesByMonthWidget> {
  final controller = injector.get<ReportController>();
  final currencyFormatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

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
              'Faturamento Mensal',
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
            if (controller.loadingReportSalesByMonth) {
              return const LoadingWidget();
            }

            if (controller.errorReportSalesByMonth.isNotEmpty) {
              return const Text(
                'Ocorreu um erro ao mostrar o gráfico de vendas por mês.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              );
            }

            final data = controller.getCompleteMonthData();
            // Valor máximo real
            final maxValue = data.map((e) => e['total'] as double).reduce(max);

            // Arredonda pro próximo "degrau", com uma folga de ~20%
            double getRoundedMaxY(double value) {
              if (value == 0) return 10;

              final base =
                  pow(10, value.toInt().toString().length - 1).toDouble();
              final rounded = (value / base).ceil() * base;

              return rounded +
                  (base * .2); // Folga no topo (20% do degrau base)
            }

            final adjustedMaxY = getRoundedMaxY(maxValue);

            // Intervalo do eixo Y: divide em 4 partes
            final yInterval = (adjustedMaxY / 4).ceilToDouble();

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF545675),
                // color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: SizedBox(
                  width: data.length * 50,
                  child: LineChart(
                    curve: Curves.easeInOut,
                    LineChartData(
                      minY: 0,
                      maxY: adjustedMaxY,
                      showingTooltipIndicators: [],

                      clipData: const FlClipData.all(),
                      gridData: const FlGridData(show: true),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, _) {
                              final index = value.toInt();
                              if (index >= 0 && index < data.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                    left: 12,
                                  ),
                                  child: Text(
                                    controller.getMonthLabel(
                                      data[index]['date'],
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            interval: yInterval,
                            getTitlesWidget: (value, _) {
                              if (value == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    'R\$ ${value.toInt()}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                );
                              }

                              if (value >= 1000) {
                                return Text(
                                  'R\$ ${(value / 1000).toStringAsFixed(1)}k',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                );
                              }

                              return Text(
                                'R\$ ${value.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            getTitlesWidget: (value, meta) {
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(color: Colors.white30),
                          left: BorderSide(color: Colors.white30),
                        ),
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (color) => Colors.black87,
                          tooltipBorderRadius: BorderRadius.circular(8),
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((spot) {
                              final value = spot.y;
                              return LineTooltipItem(
                                'R\$ ${value.toStringAsFixed(2)}',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            }).toList();
                          },
                        ),
                        handleBuiltInTouches: true,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: Colors.cyanAccent,
                              );
                            },
                          ),
                          color: Colors.cyanAccent,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00BCD4), Color(0xFF4DD0E1)],
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.cyanAccent.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          barWidth: 4,
                          spots: List.generate(data.length, (i) {
                            return FlSpot(i.toDouble(), data[i]['total']);
                          }),
                        ),
                      ],
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
