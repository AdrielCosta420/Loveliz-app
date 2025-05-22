// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ReportSalesByMonth extends ChangeNotifier {
  final String month;
  final int total;
  ReportSalesByMonth({
    required this.month,
    required this.total,
  });

  factory ReportSalesByMonth.fromMap(Map<String, dynamic> map) {
    return ReportSalesByMonth(
      month: map['month'] as String,
      total: map['total'] as int,
    );
  }

  factory ReportSalesByMonth.empty() {
    return ReportSalesByMonth(
      month: '',
      total: 0,
    );
  }

  factory ReportSalesByMonth.fromJson(String source) => ReportSalesByMonth.fromMap(json.decode(source) as Map<String, dynamic>);
}
