import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Credential {
  String? phoneNumber;
  String? password;

  Credential({this.phoneNumber, this.password});

  Credential.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}

class LoginViewModel extends BaseViewModel {
  static const String baseUrl = 'https://api.all-attend.com';
  static const String registerUserApi = '/api/auth/admin-login';

  Dio dio = Dio();

  Future<bool> login(Credential credentials) async {
    try {
      final response = await dio.post(
        '$baseUrl$registerUserApi',
        data: credentials.toJson(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;

        if (responseData.containsKey('success') && responseData['success'] == true) {
          final accessToken = responseData['data']['accessToken'] as String?;

          if (accessToken != null) {
            await saveLoginCredentials(
              credentials.phoneNumber,
              credentials.password,
              accessToken,
            );
            return true;
          } else {
            print('Login failed: Access Token is null');
          }
        } else {
          print('Login failed: Response does not indicate success');
        }
      } else {
        print('Login failed: Status Code ${response.statusCode}');
      }
      return false;
    } on DioError catch (e) {
      handleDioError(e);
      return false;
    }
  }

  Future<void> saveLoginCredentials(
      String? phoneNumber, String? password, String? accessToken) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      prefs.setString('phoneNumber', phoneNumber ?? '');
      prefs.setString('password', password ?? '');
      prefs.setString('accessToken', accessToken ?? '');
    } catch (e) {
      print('Error saving login credentials to SharedPreferences: $e');
    }
  }

  void handleDioError(DioError e) {
    print('Dio Error Details:');
    print('Response: ${e.response?.data}');
    print('Status Code: ${e.response?.statusCode}');
    print('Message: ${e.message}');
  }
}
