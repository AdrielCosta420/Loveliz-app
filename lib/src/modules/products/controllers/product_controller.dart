import 'package:flutter/material.dart';
import 'package:loveliz_app/src/modules/products/domain/models/product.dart';

class ProductController extends ChangeNotifier {
  bool isLoading = false;
  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
  
  Product product = Product();
  void setProduct(Product product) {
    this.product = product;
    notifyListeners();
  }

  List<Product> products = [];
  void setProducts(List<Product> products) {
    this.products = products;
    notifyListeners();
  }
}