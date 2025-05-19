import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../injectable.dart';
import '../../modules/user/presentation/controllers/user_controller.dart';

class AppBarMainWidget extends StatefulWidget implements PreferredSizeWidget {
  final String pageName;

  const AppBarMainWidget({
    super.key,
    required this.pageName,
    
  });

  @override
  State<AppBarMainWidget> createState() => _AppBarMainWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(85);
}

class _AppBarMainWidgetState extends State<AppBarMainWidget> {
  final UserController userController = injector.get();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.pageName,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xffd9c9ba)),
            ),
            ListenableBuilder(
              listenable: userController,
              builder: (_, __) {
                return Text(
                  userController.user.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xffffffff),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.only(right: 12),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bell)),
      ],
      toolbarHeight: 85, // Define a altura da AppBar
    );
  }
}
