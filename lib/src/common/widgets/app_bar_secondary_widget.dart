import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarSecondaryWidget extends StatelessWidget
    implements PreferredSizeWidget {
  // final String pageName;
  final String title;
  const AppBarSecondaryWidget({
    super.key,
    // required this.pageName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: const Color(0xffffffff)),
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 12),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.save)),
      ],
      toolbarHeight: 100, // Define a altura da AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // Ajusta o tamanho preferido
}
