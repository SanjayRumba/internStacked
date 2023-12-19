import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_architecture/authenticationservice.dart';
import 'package:stacked_architecture/homepage.dart';
import 'package:stacked_architecture/loginView.dart';

class StartupViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final BuildContext context;

  StartupViewModel(this.context);

  Future<void> handleStartupLogic() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second splash screen delay

    final isLoggedIn = await _authenticationService.isLoggedIn();

    if (isLoggedIn) {
      print('User is logged in.');
    } else {
      print('User is not logged in.');
    }
  }
}
