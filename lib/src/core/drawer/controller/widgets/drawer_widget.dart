import 'package:flutter/material.dart';

import '../../../../injectable.dart';

import '../../../../modules/auth/controllers/auth_controller.dart';
import '../../../routes/app_routes.dart';
import '../tfit_drawer_controller.dart';
import 'drawer_item.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final controller = injector.get<AppDrawerController>();
  final auth = injector.get<AuthController>();

  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.home_filled, 'text': 'Home', 'route': AppRoutes.home},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Image.asset('assets/images/loveliz.jpg'),
                    ),
                  ),
                ),
                ...drawerItems.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final Map<String, dynamic> item = entry.value;
                  return DrawerItem(
                    icon: item['icon'],
                    text: item['text'],
                    route: item['route'],
                    index: index,
                    isSelected: controller.selectedIndex == index,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Facebook: Azul (#3b5998)
//Instagram: Rosa (#CC2366)
//YouTube: Vermelho (#FF0000)
//Web: Azul (#0000FF)