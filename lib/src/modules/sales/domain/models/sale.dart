import 'package:flutter/material.dart';

import '../../../../common/enums/payment_method_enum.dart';
import '../../../products/domain/models/product.dart';

class Sale extends ChangeNotifier {
  final String id;
  final String productId;
  final int quantity;
  final double totalPrice;
  final DateTime createdAt;
  final PaymentMethodEnum? paymentMethod;
  final String? clientName;
  final Product? product;
  final String sellerId;
  final String sellerName;
  final String saleCode;
  Sale({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.totalPrice,
    required this.createdAt,
    this.paymentMethod,
    this.clientName,
    required this.product,
    required this.sellerId,
    required this.sellerName,
    required this.saleCode,
  });

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      totalPrice: (double.tryParse(map['totalPrice'].toString())) as double,
      createdAt: DateTime.parse(map['createdAt'] as String),
      paymentMethod:
          map['paymentMethod'] != null
              ? PaymentMethodEnum.values.singleWhere(
                (payment) =>
                    payment.name.toString().toUpperCase() ==
                    map['paymentMethod'].toString().toUpperCase(),
              )
              : null,
      clientName:
          map['clientName'] != null ? map['clientName'] as String : null,
      product: map['product'] != null ? Product.fromMap(map['product']) : null,
      sellerId: map['sellerId'] as String,
      sellerName: map['sellerName'] as String,
      saleCode: map['saleCode'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod?.name,
      'clientName': clientName,
      'sellerId': sellerId,
      'sellerName': sellerName,
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
      paymentMethod: null,
      clientName: '',
      sellerId: '',
      sellerName: '',
      saleCode: '',
    );
  }

  Sale copyWith({
    String? id,
    String? productId,
    int? quantity,
    double? totalPrice,
    DateTime? createdAt,
    PaymentMethodEnum? paymentMethod,
    String? clientName,
    Product? product,
    String? sellerId,
    String? sellerName,
    String? saleCode,
  }) {
    return Sale(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      clientName: clientName ?? this.clientName,
      product: product ?? this.product,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      saleCode: saleCode ?? this.saleCode,
    );
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
