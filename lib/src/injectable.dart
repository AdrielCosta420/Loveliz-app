import 'package:get_it/get_it.dart';
import 'modules/products/product_injector.dart';
import 'modules/reports/report_inject.dart';
import 'modules/sales/sale_injector.dart';

import 'core/core_injector.dart';
import 'modules/auth/auth_injector.dart';
import 'modules/user/user_injector.dart';

final injector = GetIt.instance;

void setupInjection() {
  AuthInjector.inject(injector);
  CoreInjector.inject(injector);
  ProductInjector.inject(injector);
  SaleInjector.inject(injector);
  UserInjector.inject(injector);
  ReportInjector.inject(injector);
}
