import 'package:flutter/material.dart';
import 'package:loveliz_app/src/modules/home/pages/home_page.dart';
import 'package:loveliz_app/src/modules/auth/presentation/login_page.dart';
import 'package:loveliz_app/src/modules/products/presentation/pages/products_page.dart';
import 'package:loveliz_app/src/splash_page.dart';

import '../../modules/sales/ui/pages/register_sale_page.dart';

sealed class AppRoutes {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const products = '/products';
  static const registerSale = '/register-sale';
  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashPage(),
      home: (context) => const HomePage(),
      login: (context)=> const LoginPage(), 
      products: (context) => const ProductsPage(),
      registerSale: (context) => const RegisterSalePage(),
    };
  }
}
