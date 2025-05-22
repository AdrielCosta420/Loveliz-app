// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:loveliz_app/src/common/enums/payment_method_enum.dart';

class ReportSalesByPaymentMethod extends ChangeNotifier {
  final PaymentMethodEnum paymentMethod;
  final int totalRevenue;
  ReportSalesByPaymentMethod({
    required this.paymentMethod,
    required this.totalRevenue,
  });

  factory ReportSalesByPaymentMethod.fromMap(Map<String, dynamic> map) {
    return ReportSalesByPaymentMethod(
      paymentMethod: PaymentMethodEnum.values.singleWhere((method) => method.name.toString().toUpperCase() == map['method'].toString().toUpperCase()),
      totalRevenue: map['totalRevenue'] as int,
    );
  }


  factory ReportSalesByPaymentMethod.fromJson(String source) => ReportSalesByPaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);
}
