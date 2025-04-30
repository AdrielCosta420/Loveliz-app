
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences? _instance;

  Preferences._();

  static Preferences get instance {
    _instance ??= Preferences._();
    return _instance!;
  }

  Future<SharedPreferences> _getInstance() => SharedPreferences.getInstance();

  //----------------TOKEN----------------\\
  Future<String> getToken() async {
    final prefs = await _getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> setToken(String token) async {
    final prefs = await _getInstance();
    await prefs.setString('token', token);
  }

  Future<void> clearToken() async {
    final prefs = await _getInstance();
    await prefs.remove('token');
  }

    //-----------------Coach--------------------------\\
  // Future<void> setUserCoach(Coach coach) async {
  //   final prefs = await _getInstance();
  //   await prefs.setString('user_coach', coach.toJson());
  // }

  // Future<Coach?> getUserCoach() async {
  //   final prefs = await _getInstance();
  //   final coach = prefs.getString('user_coach');
  //   if(coach == null) return null;
  //   return Coach.fromJson(coach);
  // }

  // Future<void> clearUserCoach() async {
  //   final prefs = await _getInstance();
  //   await prefs.remove('user_coach');
  // }
}
