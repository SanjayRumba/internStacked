import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_architecture/homepageViewModel.dart';
import 'package:stacked_architecture/loginView.dart';
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      onModelReady: (model) async {
        await model.getAccessToken();
      },
      viewModelBuilder: () => DashboardViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                model.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Access Token: ${model.accessToken}'),
            ],
          ),
        ),
      ),
    );
  }
}
