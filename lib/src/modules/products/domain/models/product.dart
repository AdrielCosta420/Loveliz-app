import 'dart:convert';

import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  String id;
  double price;
  String model;
  String color;
  String size;
  int quantity;
  int quantityByModel;
  int quantityByColor;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id = '',
    this.price = 0.0,
    this.model = '',
    this.color = '',
    this.size = '',
    this.quantity = 0,
    this.quantityByModel = 0,
    this.quantityByColor = 0,
    this.createdAt,
    this.updatedAt,
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

  void setSize(String size) {
    this.size = size;
    notifyListeners();
  }

  void setQuantity(int quantity) {
    this.quantity = quantity;
    notifyListeners();
  }

  void setQuantityByModel(int quantityByModel) {
    this.quantityByModel = quantityByModel;
    notifyListeners();
  }

  void setQuantityByColor(int quantityByColor) {
    this.quantityByColor = quantityByColor;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'model': model,
      'color': color,
      'size': size,
      'quantity': quantity,
      'quantityByModel': quantityByModel,
      'quantityByColor': quantityByColor,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      price: double.tryParse(map['price'].toString()) ?? 0.0,
      model: map['model'] ?? '',
      color: map['color'] ?? '',
      size: map['size'] ?? '',
      quantity: map['quantity'] ?? 0,
      quantityByModel: map['quantityByModel'] ?? 0,
      quantityByColor: map['quantityByColor'] ?? 0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
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
      size: '',
      quantity: 0,
      quantityByModel: 0,
      quantityByColor: 0,
      createdAt: null,
      updatedAt: null,
    );
  }
}
