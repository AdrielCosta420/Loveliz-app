import 'package:flutter/material.dart';

import '../../injectable.dart';
import '../drawer/controller/tfit_drawer_controller.dart';
import '../routes/app_routes.dart';

enum TransitionType { slideLR, slideRL, fade, scale }

sealed class AppNavigator {
  // Instância do controlador do Drawer


  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
    static final AppDrawerController drawerController = injector.get<AppDrawerController>();

  // Navegar para uma rota com o tipo de animação escolhido
  static Future<void> navigateTo(String routeName, {Object? arguments, TransitionType transition = TransitionType.slideLR}) {
    return _navigatorKey.currentState!.push(_createRoute(routeName, arguments: arguments, transition: transition));
  }

  // Navegar para uma rota com animação e remover as rotas anteriores
  static Future<void> navigateToAndRemove(String routeName, {Object? arguments, TransitionType transition = TransitionType.fade}) {
    if (routeName == AppRoutes.home) {
      drawerController.setIndex(0);
    }
    return _navigatorKey.currentState!.pushAndRemoveUntil(
      _createRoute(routeName, arguments: arguments, transition: transition),
      (route) => false,
    );
  }

  // Faz um pop porem achei mais legal chamar de goBack
  //Não utilizar nas rotas principais pois o padrão das rotas principais vai ser o navigateToAndRemove pois remove a pilha
  static void goBack() {
    _navigatorKey.currentState!.pop();
  }

  // Função para criar rota com animação personalizada
  static Route _createRoute(String routeName, {Object? arguments, TransitionType transition = TransitionType.slideLR}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) {
        // Obter a tela diretamente do AppRoutes
        //Esse aqui é osso, verificar com mais calma pois usa o context do pageBuilder
        return _getScreenFromRoute(routeName, context) ?? const SizedBox.shrink();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transition) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.slideRL:
            const beginRL = Offset(-1.0, 0.0);
            const endRL = Offset.zero;
            final tweenRL = Tween(begin: beginRL, end: endRL).chain(CurveTween(curve: Curves.ease));
            final offsetAnimationRL = animation.drive(tweenRL);
            return SlideTransition(position: offsetAnimationRL, child: child);

          case TransitionType.slideLR:
          const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
        }
      },
    );
  }

  // Função para obter a tela usando o AppRoutes
  static Widget? _getScreenFromRoute(String routeName, BuildContext context) {
    final routeBuilder = AppRoutes.routes[routeName];
    return routeBuilder != null ? routeBuilder(context) : null;
  }
}
