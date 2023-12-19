import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_architecture/authenticationservice.dart';

class DashboardViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = AuthenticationService();

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
    await _authenticationService.logout();
    // Clear the accessToken value
    _accessToken = '';
    notifyListeners();
    print('Logged out. Access Token cleared.');
  }
}
