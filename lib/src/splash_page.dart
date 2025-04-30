import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'injectable.dart';
import 'modules/auth/controllers/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = injector.get<AuthController>();

  @override
  void initState() {
    controller.getTokenByPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.progressiveDots(
          color: const Color(0xffffbbca),
          size: 40,
        ),
      ),
    );
  }
}
