import 'package:MoxifyMTG/app_router.dart';
import 'package:MoxifyMTG/theme/material_theme_wrapper.dart';
import 'package:flutter/material.dart';

void main() {
  final appRouter = AppRouter();

  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.appRouter, super.key});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialThemeWrapper(
      appRouter: appRouter,
    );
  }
}
