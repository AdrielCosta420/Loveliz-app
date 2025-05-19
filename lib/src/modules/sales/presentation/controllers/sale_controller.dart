import 'package:flutter/material.dart';
import 'package:loveliz_app/src/modules/sales/domain/models/sale.dart';

class SaleController extends ChangeNotifier {
  bool isLoading = false;
  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Sale sale = Sale.empty();
  void setSale(Sale sale) {
    this.sale = sale;
    notifyListeners();
  }

  List<Sale> sales = [];
  void setSales(List<Sale> sales) {
    this.sales = sales;
    notifyListeners();
  }

  int get totalSales => sales.length;
  double get totalPrice {
    double total = 0.0;
    for (var sale in sales) {
      total += sale.totalPrice;
    }
    return total;
  }

  List<Sale> lastSale = [];
  void setLastSale(List<Sale> lastSales) {
    lastSale = lastSales;
    notifyListeners();
  }

  bool isLastSaleLoading = false;
  void setLastSaleLoading(bool loading) {
    isLastSaleLoading = loading;
    notifyListeners();
  }

  String lastSaleError = '';
  void setLastSaleError(String error) {
    lastSaleError = error;
    notifyListeners();
  }
}
