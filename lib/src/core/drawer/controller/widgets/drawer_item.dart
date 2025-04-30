import 'package:flutter/material.dart';

import '../../../../injectable.dart';
import '../../../providers/app_navigator.dart';
import '../tfit_drawer_controller.dart';

class DrawerItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final String route;
  final int index;
  final bool isSelected;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.route,
    required this.index,
    required this.isSelected,
  });

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  final controller = injector.get<AppDrawerController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, color: widget.isSelected ? Colors.blue : Colors.grey[700]),
      title: Text(
        widget.text,
        style: TextStyle(
          color: widget.isSelected ? Colors.blue : Colors.grey[700],
          fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        controller.setIndex(widget.index);
        AppNavigator.navigateToAndRemove(widget.route);
      },
    );
  }
}
