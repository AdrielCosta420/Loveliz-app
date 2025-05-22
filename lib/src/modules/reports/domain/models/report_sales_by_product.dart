// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ReportSalesByProduct extends ChangeNotifier {
  final String productName;
  final int totalSold;
  final int totalRevenue;
  ReportSalesByProduct({
    required this.productName,
    required this.totalSold,
    required this.totalRevenue,
  });

  factory ReportSalesByProduct.fromMap(Map<String, dynamic> map) {
    return ReportSalesByProduct(
      productName: map['productName'] as String,
      totalSold: map['totalSold'] as int,
      totalRevenue: map['totalRevenue'] as int,
    );
  }

  factory ReportSalesByProduct.empty() {
    return ReportSalesByProduct(
      productName: '',
      totalSold: 0,
      totalRevenue: 0,
    );
  }

  factory ReportSalesByProduct.fromJson(String source) =>
      ReportSalesByProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
