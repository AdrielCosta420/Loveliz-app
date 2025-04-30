import 'package:get_it/get_it.dart';
import 'package:loveliz_app/src/modules/products/product_injector.dart';
import 'package:loveliz_app/src/modules/sales/ui/pages/sale_injector.dart';

import 'core/core_injector.dart';
import 'modules/auth/auth_injector.dart';

final injector = GetIt.instance;

void setupInjection() {
  AuthInjector.inject(injector);
  CoreInjector.inject(injector);
  ProductInjector.inject(injector);
  SaleInjector.inject(injector);
}
