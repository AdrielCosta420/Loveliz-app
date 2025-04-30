import 'package:flutter/material.dart';
import 'package:loveliz_app/src/modules/auth/dtos/credentials.dart';

import '../../../common/typedef/typedef.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/providers/app_navigator.dart';
import '../../../core/routes/app_routes.dart';

class AuthController extends ChangeNotifier {
  
  String userRole = '';
  void setUserRole(String role) {
    userRole = role;
    notifyListeners();
  }

  Credentials credentials = Credentials();
  String? errorLogin;
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  AuthController() {
    getTokenByPreferences();
  }

  AccessToken token = '';
  void setToken(AccessToken token) {
    this.token = token;
    notifyListeners();
  }

  void clearToken() {
    token = '';
    notifyListeners();
  }

  Future<void> getTokenByPreferences() async {
    if (token.isNotEmpty) return;

    final fetchedToken = await Preferences.instance.getToken();
    if (fetchedToken.isNotEmpty) {
      token = fetchedToken;
      AppNavigator.navigateTo(AppRoutes.home);
      notifyListeners();
    }
  }
}
