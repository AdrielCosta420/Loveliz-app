import 'package:flutter/material.dart';
import '../domain/models/product.dart';

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

  bool isLoadingTopProducts = false;
  void setLoadingTopProducts(bool value) {
     isLoadingTopProducts = value;
    notifyListeners();
  }

  List<Product> topProducts = [];
  void setTopProducts(List<Product> products) {
    topProducts = products;
    notifyListeners();
  }
  
  String errorMessageTopProducts = '';
  void setErrorMessageTopProducts(String message) {
    errorMessageTopProducts = message;
    notifyListeners();
  }

  GlobalKey<FormState> createProductForm = GlobalKey<FormState>();
  GlobalKey<FormState> updateProductForm = GlobalKey<FormState>();

}