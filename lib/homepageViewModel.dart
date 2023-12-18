import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardViewModel extends BaseViewModel {
  String _accessToken = '';

  String get accessToken => _accessToken;

  Future<void> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString('accessToken') ?? '';
      notifyListeners();
    } catch (e) {
      // Handle SharedPreferences read failure
      print('Error reading accessToken from SharedPreferences: $e');
    }
  }

Future<void> logout() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('accessToken');
    _accessToken = ''; // Clear the accessToken value
    notifyListeners();
    print('Logged out. Access Token cleared.');
  } catch (e) {
    // Handle SharedPreferences remove failure
    print('Error removing accessToken from SharedPreferences: $e');
  }
}
}
