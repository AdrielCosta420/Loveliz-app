// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class ReportSalesBySeller extends ChangeNotifier {
  final Sum sum;
  final Count count;
  final String sellerId;
  final String sellerName;
  ReportSalesBySeller({
    required this.sum,
    required this.count,
    required this.sellerId,
    required this.sellerName,
  });



  factory ReportSalesBySeller.fromMap(Map<String, dynamic> map) {
    return ReportSalesBySeller(
      sum: Sum.fromMap(map['_sum']),
      count: Count.fromMap(map['_count']),
      sellerId: map['sellerId'] as String,
      sellerName: map['sellerName'] as String,
    );
  }

  factory ReportSalesBySeller.empty() {
    return ReportSalesBySeller(
      sum: Sum(totalPrice: 0),
      count: Count(totalCount: 0),
      sellerId: '',
      sellerName: '',
    );
  }
  

  factory ReportSalesBySeller.fromJson(String source) => ReportSalesBySeller.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Sum {
  final int totalPrice;
  Sum({
    required this.totalPrice,
  });

  factory Sum.fromMap(Map<String, dynamic> map) {
    return Sum(
      totalPrice: map['totalPrice'] as int,
    );
  }
}

class Count {
  final int totalCount;
  Count({
    required this.totalCount,
  });

  factory Count.fromMap(Map<String, dynamic> map) {
    return Count(
      totalCount: map['_all'] as int,
    );
  }
}
