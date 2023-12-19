import 'package:flutter/material.dart';
import 'package:stacked_architecture/authenticationservice.dart';
import 'package:stacked_architecture/homepage.dart';
import 'package:stacked_architecture/loginView.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second splash screen delay

    final isLoggedIn = await _authenticationService.isLoggedIn();

    if (isLoggedIn) {
      // User is already logged in, navigate to DashboardPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } else {
      // User is not logged in, navigate to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your splash screen content (logo, app name, etc.)
            Image.asset('assets/splash_image.png', height: 150, width: 150),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
