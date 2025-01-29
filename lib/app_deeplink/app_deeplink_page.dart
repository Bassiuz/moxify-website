import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppDeeplinkPage extends StatelessWidget {
  const AppDeeplinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold
      appBar: AppBar(
        // AppBar
        title: const Text('App Deeplink Page'), // Text
      ), // AppBar
      body: Center(
        // Center
        child: Column(
          // Column
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Uri.base.toString()), // Text
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
