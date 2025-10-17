import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class QRLandingPage extends StatefulWidget {
  const QRLandingPage({super.key});

  @override
  State<QRLandingPage> createState() => _QRLandingPageState();
}

class _QRLandingPageState extends State<QRLandingPage> {
  late String backdrop;

  @override
  void initState() {
    super.initState();

    // Initialize backdrop image
    backdrop = [
      'assets/backdrop/backdrop1.jpg',
      'assets/backdrop/backdrop2.jpg',
      'assets/backdrop/backdrop3.jpg',
      'assets/backdrop/backdrop4.png',
      'assets/backdrop/backdrop5.png',
    ].elementAt(DateTime.now().second % 5);
  }

  /// Helper function to launch URLs safely.
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  void dispose() {
    // No controller to dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backdrop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Frosted Glass/Blur Effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Centered Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 450,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        child: Column(
                          children: [
                            // Header: Logo and Title
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logo/moxify.png',
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Moxify',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    Text(
                                      'Collect - Scan - Track',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Explanation Text
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Welcome! Moxify is a new scanning app for your Magic: The Gathering cards, currently in very early development.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // App Demo (as an animated WebP)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/demo/demo.webp',
                                // You can optionally add fit: BoxFit.cover
                                // if the aspect ratio isn't quite right.
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Discord Button
                            FilledButton.icon(
                              icon: const Icon(Icons.discord),
                              label: const Text('Join Discord to Test & Give Feedback'),
                              onPressed: () {
                                _launchUrl('https://discord.gg/rVsvSxbBug');
                              },
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Store Badges
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _launchUrl(
                                      // Use the helper
                                      'https://apps.apple.com/nl/app/moxify-mtg/id6739588255?l=en-GB',
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
                                    _launchUrl(
                                      // Use the helper
                                      'https://play.google.com/store/apps/details?id=com.bassiuz.moxify',
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
