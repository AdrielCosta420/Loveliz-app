import 'package:flutter/material.dart';

class AppBarSecondaryWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const AppBarSecondaryWidget({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: const Color(0xffffffff)),
      ),
      actions: actions,
      actionsPadding: const EdgeInsets.only(right: 12),
      toolbarHeight: 85, // Define a altura da AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(85); // Ajusta o tamanho preferido
}
