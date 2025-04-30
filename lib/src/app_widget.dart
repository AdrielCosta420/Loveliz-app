import 'package:flutter/material.dart';
import 'package:loveliz_app/src/core/routes/app_routes.dart';
import 'package:loveliz_app/src/core/providers/app_navigator.dart';

import 'core/themes/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Love Liz',
      routes: AppRoutes.routes,
      navigatorKey: AppNavigator.navigatorKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}
