import 'package:flutter/material.dart';
import 'package:loveliz_app/src/modules/products/domain/models/product.dart';

class Sale extends ChangeNotifier {
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;
  final DateTime createdAt;
  final String? paymentMethod;
  final String? clientName;
  final Product product;
  Sale({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    this.paymentMethod,
    this.clientName,
    required this.product,
  });

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      totalPrice: (double.tryParse(map['totalPrice'].toString())) as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as String : null,
      clientName:
          map['clientName'] != null ? map['clientName'] as String : null,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod,
      'clientName': clientName,
      'product': product.toMap(),
    };
  }

  factory Sale.empty() {
    return Sale(
      id: '',
      productId: '',
      quantity: 0,
      totalPrice: 0.0,
      createdAt: DateTime.now(),
      product: Product.empty(),
    );
  }
}
