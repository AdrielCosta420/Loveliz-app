
import 'package:flutter/material.dart';

class CollectionProduct extends ChangeNotifier {
  String id;
  String name;
  List<String>? products;
  CollectionProduct({required this.id, required this.name, this.products});

  void setId(String value) {
    id = value;
    notifyListeners();
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setProducts(List<String> ids) {
    products = ids;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'products': products};
  }

  factory CollectionProduct.fromMap(Map<String, dynamic> map) {
    return CollectionProduct(
      id: map['id'] as String,
      name: map['name'] as String,
      products: map['products'] != null ? List<dynamic>.from(map['products']).map((e) => e.toString()).toList() : null
          // map['products'] != null
              // ? List<String>.from((map['products'] as List<String>))
              // : null,
    );
  }

  factory CollectionProduct.isEmpty() {
    return CollectionProduct(id: '', name: '', products: []);
  }
}
