import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _key = 'isLoggedIn';
  static const _username = 'admin';
  static const _password = '123';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<bool> login(String username, String password) async {
    if (username != _username || password != _password) return false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}