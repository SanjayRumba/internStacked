import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin') ?? false;
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('accessToken');
      prefs.setBool('isLogin', false); // Set login status to false
    } catch (e) {
      // Handle SharedPreferences remove failure
      print('Error removing accessToken from SharedPreferences: $e');
    }
  }
}