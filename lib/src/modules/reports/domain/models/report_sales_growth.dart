import 'dart:convert';

import 'package:flutter/material.dart';

class ReportSalesGrowth extends ChangeNotifier {
  final String month;
  final int total;
  final int? growthPercentage;
  ReportSalesGrowth({required this.month, required this.total, this.growthPercentage});

  factory ReportSalesGrowth.fromMap(Map<String, dynamic> map) {
    return ReportSalesGrowth(
      month: map['month'] as String,
      total: map['total'] as int,
      growthPercentage: map['growth'] != null
          ? (map['growth']) as int
          : null,
    );
  }

  factory ReportSalesGrowth.fromJson(String source) =>
      ReportSalesGrowth.fromMap(jsonDecode(source));
}
