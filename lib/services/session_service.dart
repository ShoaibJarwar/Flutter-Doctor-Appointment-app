import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  Future<void> saveLogin(int userId) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);

    await prefs.setInt('userId', userId);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('isLoggedIn');
  }
}
