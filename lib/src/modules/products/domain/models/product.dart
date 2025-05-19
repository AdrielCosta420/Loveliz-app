import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../common/enums/product_sizes_enum.dart';

class Product extends ChangeNotifier {
  String id;
  double price;
  String model;
  String color;
  ProductSizesEnum size;
  int quantity;
  String collectionId;
  String collectionName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int totalSold;
  bool active;
  Product({
    this.id = '',
    this.price = 0.0,
    this.model = '',
    this.color = '',
    this.size = ProductSizesEnum.padrao,
    this.quantity = 0,
    this.collectionId = '',
    this.collectionName = '',
    this.createdAt,
    this.updatedAt,
    this.totalSold = 0,
    this.active = true,
  });

  void setId(String id) {
    this.id = id;
    notifyListeners();
  }

  void setPrice(double price) {
    this.price = price;
    notifyListeners();
  }

  void setModel(String model) {
    this.model = model;
    notifyListeners();
  }

  void setColor(String color) {
    this.color = color;
    notifyListeners();
  }

  void setSize(ProductSizesEnum size) {
    this.size = size;
    notifyListeners();
  }

  void setQuantity(int quantity) {
    this.quantity = quantity;
    notifyListeners();
  }

  void setTotalSold(int value) {
    value = totalSold;
    notifyListeners();
  }

  void setCollectionId(String collectionId) {
    this.collectionId = collectionId;
    notifyListeners();
  }

  void setCollectionName(String collectionName) {
    this.collectionName = collectionName;
    notifyListeners();
  }

  void setActive(bool active) {
    this.active = active;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'model': model,
      'color': color,
      'size': size.name,
      'quantity': quantity,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'active': active,
      
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      model: map['model'] ?? '',
      color: map['color'] ?? '',
      size: ProductSizesEnum.values.singleWhere(
        (element) => element.name == map['size'],
      ),
      quantity: map['quantity'] ?? 0,
      totalSold: map['totalSold'] ?? 0,
      collectionId: map['collectionId'] ?? '',
      collectionName: map['collectionName'] ?? '',
      active: map['active'] ?? true,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  factory Product.fromJson(String source) => jsonDecode(source);

  String toJson() => json.encode(toMap());

  factory Product.empty() {
    return Product(
      id: '',
      price: 0.0,
      model: '',
      color: '',
      size: ProductSizesEnum.padrao,
      quantity: 0,
      totalSold: 0,
      createdAt: null,
      updatedAt: null,
      active: true,
      collectionId: '',
      collectionName: '',

    );
  }
}
