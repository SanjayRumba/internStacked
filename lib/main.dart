import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_architecture/splashscreen.dart';
import 'package:stacked_architecture/startupViewModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(context),
      onModelReady: (model) => model.handleStartupLogic(),
      builder: (context, model, child) => MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
