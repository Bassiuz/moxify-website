import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: unused_import
import 'package:url_launcher_web/url_launcher_web.dart';

@RoutePage()
class AppDeeplinkPage extends StatefulWidget {
  const AppDeeplinkPage({super.key});

  @override
  State<AppDeeplinkPage> createState() => _AppDeeplinkPageState();
}

class _AppDeeplinkPageState extends State<AppDeeplinkPage> {
  late String backdrop;

  @override
  void initState() {
    super.initState();
    backdrop = [
      'assets/backdrop/backdrop1.jpg',
      'assets/backdrop/backdrop2.jpg',
      'assets/backdrop/backdrop3.jpg',
      'assets/backdrop/backdrop4.png',
      'assets/backdrop/backdrop5.png',
    ].elementAt(DateTime.now().second % 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backdrop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.white.withOpacity(0.2), // This is necessary to apply the blur effect
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: SizedBox(
                    height: 500,
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logo/moxify.png',
                                  width: 100,
                                  height: 100,
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Moxify',
                                      style: Theme.of(context).textTheme.headlineLarge,
                                    ),
                                    Text(
                                      'Collect - Scan - Track',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 220,
                            width: 220,
                            // white background with rounded corners
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: QrImageView(
                                data: Uri.base.toString(),
                                size: 200,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://apps.apple.com/nl/app/moxify-mtg/id6739588255?l=en-GB',
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 140,
                                    child: SvgPicture.asset(
                                      'assets/badges/appstore.svg',
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(
                                      Uri.parse(
                                        'https://play.google.com/store/apps/details?id=com.bassiuz.moxify',
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 60,
                                    width: 150,
                                    child: Image.asset(
                                      'assets/badges/googleplay.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
