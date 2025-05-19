import 'package:flutter/material.dart';
import '../../modules/home/pages/home_page.dart';
import '../../modules/auth/presentation/login_page.dart';
import '../../modules/products/presentation/pages/collections_product_page.dart';
import '../../modules/products/presentation/pages/products_page.dart';
import '../../splash_page.dart';

import '../../modules/sales/presentation/pages/register_sale_page.dart';

sealed class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const collectionsProduct = '/collections-product';
  static const products = '/collections-product/products';
  static const registerSale = '/register-sale';
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashPage(),
      home: (context) => const HomePage(),
      login: (context) => const LoginPage(),
      collectionsProduct: (context) => const CollectionsProductPage(),
      products: (context) => const ProductsPage(),
      registerSale: (context) => const RegisterSalePage(),
    };
  }
}
