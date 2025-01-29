import 'package:MoxifyMTG/copyright_notice.dart';
import 'package:MoxifyMTG/privacy_policy.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // logo
        children: <Widget>[
          const SizedBox(height: 40),
          Image.asset(
            'assets/logo/moxify.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 40),

          // title
          Center(
            child: Text(
              'Moxify MTG',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: 20),
          // counter
          Center(
            child: Text(
              'Collect - Scan - Track',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 20),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 20),

              // button
              Flexible(
                child: Text(privacyPolicy),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(copyrightNotice),
              ),
              SizedBox(width: 20),
            ],
          ),

          // button
        ],
      ),
    );
  }
}
