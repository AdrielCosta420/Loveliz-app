import 'dart:developer';

import 'package:loveliz_app/src/core/preferences/preferences.dart';
import 'package:loveliz_app/src/modules/auth/controllers/auth_controller.dart';
import 'package:loveliz_app/src/modules/auth/repositories/auth_repository.dart';

import '../../../common/functions/decode_jwt.dart';
import '../../../common/snackbar/snackbar_custom.dart';
import '../../../core/providers/app_navigator.dart';
import '../../../core/routes/app_routes.dart';
import '../../../injectable.dart';

abstract interface class LoginUc {
  Future<void> call();
}

class LoginUcImpl implements LoginUc {
  final controller = injector.get<AuthController>();
  final _repository = injector.get<AuthRepository>();
  Preferences? preferences = Preferences.instance;

  @override
  Future<void> call() async {
    controller.setLoading(true);
    try {
      final response = await _repository.login(
        credentials: controller.credentials,
      );

      response.fold(
        (failure) {
          log(failure.message);
        },
        (success) async {
          log(success);
          await preferences?.setToken(success);
          controller.setToken(success);
          final map = DecodeJwt.decode(success);
          controller.setUserRole(map['role']);
          controller.setUserId(map['id']);
          AppNavigator.navigateTo(AppRoutes.home);
        },
      );
    } on Exception catch (e) {
      SnackbarCustom.failure(e.toString());
    }
    finally {
      controller.setLoading(false);
    }
  }
}
