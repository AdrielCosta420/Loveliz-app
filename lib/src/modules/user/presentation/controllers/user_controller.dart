import 'package:flutter/material.dart';

import '../../domain/models/user.dart';

class UserController extends ChangeNotifier {
  User user = User(
    id: '',
    name: '',
    email: '',
    role: '',
  );

  void setUser(User newUser) {
    user = newUser;
    notifyListeners();
  }
}