import 'package:MoxifyMTG/app_deeplink/app_deeplink_page.dart';
import 'package:MoxifyMTG/homepage/homepage.dart';
import 'package:flutter/material.dart';

class Routes {
  // Route name constants
  static const String homeScreen = '/';
  static const String appScreen = '/app';

  /// The map used to define routes to be provided in [MaterialApp]
  static final Map<String, WidgetBuilder> allRoutes = {
    homeScreen: (context) => const MyHomePage(),
    appScreen: (context) => const AppDeeplinkPage(),
  };
}
