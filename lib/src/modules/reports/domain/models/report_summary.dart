// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ReportSummary extends ChangeNotifier {
  final int totalSales;
  final int totalRevenue;
  ReportSummary({required this.totalSales, required this.totalRevenue});

  factory ReportSummary.fromMap(Map<String, dynamic> map) {
    return ReportSummary(
      totalSales: map['totalSales'] as int,
      totalRevenue: map['totalRevenue'] as int,
    );
  }

  factory ReportSummary.empty() {
    return ReportSummary(
      totalSales: 0,
      totalRevenue: 0,
    );
  }
  factory ReportSummary.fromJson(String source) =>
      ReportSummary.fromMap(json.decode(source) as Map<String, dynamic>);
}
