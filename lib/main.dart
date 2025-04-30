import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loveliz_app/src/app_widget.dart';
import 'src/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  await initializeDateFormatting('pt_BR', null);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFA6767A),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));

  runApp(const AppWidget());
}
