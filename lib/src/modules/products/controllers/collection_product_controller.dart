import 'package:flutter/material.dart';

import '../domain/models/collection_product.dart';
import '../domain/models/product.dart';

class CollectionProductController extends ChangeNotifier {
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String errorCollections = '';
  void setErrorCollections(String value) {
    errorCollections = value;
  }

  List<CollectionProduct> collections = [];
  void setCollections(List<CollectionProduct> values) {
    collections = values;
    notifyListeners();
  }


  CollectionProduct collection = CollectionProduct.isEmpty();
  void setCollection(CollectionProduct value) {
    collection = value;
    notifyListeners();
  }

  List<Product> productsByCollection = [];
  void setProductsByCollection(List<Product> values) {
    productsByCollection = values;
    notifyListeners();
  }

  bool isLoadingProducts = false;
  void setLoadingProducts(bool value) {
    isLoadingProducts = value;
    notifyListeners();
  }
  String errorProducts = '';
  void setErrorProducts(String value) {
    errorProducts = value;
    notifyListeners();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


}
