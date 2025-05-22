import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/models/report_sales_by_month.dart';
import '../../domain/models/report_sales_by_payment_method.dart';
import '../../domain/models/report_sales_by_product.dart';
import '../../domain/models/report_sales_by_seller.dart';
import '../../domain/models/report_sales_growth.dart';
import '../../domain/models/report_summary.dart';

class ReportController extends ChangeNotifier {
  bool loadingReportSalesByMonth = false;
  void setLoadingReportSalesByMonth(bool loading) {
    loadingReportSalesByMonth = loading;
    notifyListeners();
  }

  String errorReportSalesByMonth = '';
  void setErrorReportSalesByMonth(String error) {
    errorReportSalesByMonth = error;
    notifyListeners();
  }

  List<ReportSalesByMonth> reportSalesByMonth = [];
  void setReportSalesByMonth(List<ReportSalesByMonth> reports) {
    reportSalesByMonth = reports;
    notifyListeners();
  }

  List<Map<String, dynamic>> getCompleteMonthData() {
    final now = DateTime.now();
    final start = DateTime(now.year, 1);
    final end = DateTime(now.year, now.month + 2);
    final formatter = DateFormat('yyyy-MM');
    DateTime current = start;
    List<Map<String, dynamic>> finalList = [];

    while (!current.isAfter(end)) {
      final formatted = formatter.format(current);

      final match = reportSalesByMonth.firstWhere(
        (e) => e.month == formatted,
        orElse: () => ReportSalesByMonth(month: formatted, total: 0),
      );

      finalList.add({'date': current, 'total': match.total.toDouble()});

      // Próximo mês
      current = DateTime(current.year, current.month + 1);
    }

    return finalList;
  }

  String getMonthLabel(DateTime date) {
    return DateFormat.MMM('pt_BR').format(date).toUpperCase();
  }

  

  //------------------------------//---------------------------------------
  bool loadingReportSalesByProduct = false;
  void setLoadingReportSalesByProduct(bool loading) {
    loadingReportSalesByProduct = loading;
    notifyListeners();
  }

  String errorReportSalesByProduct = '';
  void setErrorReportSalesByProduct(String error) {
    errorReportSalesByProduct = error;
    notifyListeners();
  }

  List<ReportSalesByProduct> reportSalesByProduct = [];
  void setReportSalesByProduct(List<ReportSalesByProduct> reports) {
    reportSalesByProduct = reports;
    notifyListeners();
  }

  double getYAxisInterval(List<ReportSalesByProduct> data) {
    final maxValue =
        data.map((e) => e.totalSold).reduce((a, b) => a > b ? a : b).toDouble();

    // Arredonda pra cima e dá uma folga
    final base = pow(10, maxValue.toInt().toString().length - 1).toDouble();
    final adjustedMax = (maxValue / base).ceil() * base + base * 0.2;

    return (adjustedMax / 4).ceilToDouble();
  }
  //------------------------------//---------------------------------------

  bool loadingReportSalesBySeller = false;
  void setLoadingReportSalesBySeller(bool loading) {
    loadingReportSalesBySeller = loading;
    notifyListeners();
  }

  String errorReportSalesBySeller = '';
  void setErrorReportSalesBySeller(String error) {
    errorReportSalesBySeller = error;
    notifyListeners();
  }

  List<ReportSalesBySeller> reportSalesBySeller = [];
  void setReportSalesBySeller(List<ReportSalesBySeller> reports) {
    reportSalesBySeller = reports;
    notifyListeners();
  }

  //------------------------------//---------------------------------------

  bool loadingReportSummary = false;
  void setLoadingReportSummary(bool loading) {
    loadingReportSummary = loading;
    notifyListeners();
  }

  String errorReportSummary = '';
  void setErrorReportSummary(String error) {
    errorReportSummary = error;
    notifyListeners();
  }

  ReportSummary reportSummary = ReportSummary.empty();
  void setReportSummary(ReportSummary reports) {
    reportSummary = reports;
    notifyListeners();
  }
  //------------------------------//---------------------------------------

  bool loadingReportSalesGrowth = false;
  void setLoadingReportSalesGrowth(bool loading) {
    loadingReportSalesGrowth = loading;
    notifyListeners();
  }

  String errorReportSalesGrowth = '';
  void setErrorReportSalesGrowth(String error) {
    errorReportSalesGrowth = error;
    notifyListeners();
  }

  List<ReportSalesGrowth> reportSalesGrowth = [];
  void setReportSalesGrowth(List<ReportSalesGrowth> reports) {
    reportSalesGrowth = reports;
    notifyListeners();
  }

  //------------------------------//---------------------------------------

  bool loadingReportSalesByPaymentMethod = false;
  void setLoadingReportSalesByPaymentMethod(bool loading) {
    loadingReportSalesByPaymentMethod = loading;
    notifyListeners();
  }

  String errorReportSalesByPaymentMethod = '';
  void setErrorReportSalesByPaymentMethod(String error) {
    errorReportSalesByPaymentMethod = error;
    notifyListeners();
  }

  List<ReportSalesByPaymentMethod> reportSalesByPaymentMethod = [];
  void setReportSalesByPaymentMethod(List<ReportSalesByPaymentMethod> reports) {
    reportSalesByPaymentMethod = reports;
    notifyListeners();
  }
}
