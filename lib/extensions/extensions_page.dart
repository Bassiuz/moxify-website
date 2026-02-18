import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ExtensionsPage extends StatefulWidget {
  const ExtensionsPage({super.key});

  @override
  State<ExtensionsPage> createState() => _ExtensionsPageState();
}

class _ExtensionsPageState extends State<ExtensionsPage> {
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

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
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
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: SelectionArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 24),
                          child: Column(
                            children: [
                              // Header
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Moxfield Sync',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      Text(
                                        'Browser Extension',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Description
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'Moxify Sync connects your Moxify app with your Moxfield account. '
                                  'Export decks and binders from Moxfield into Moxify, or import your '
                                  'Moxify collection to Moxfield — all through a simple QR code scan.',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Browser cards
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth > 500) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: _buildChromeCard(context),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: _buildFirefoxCard(context),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        _buildChromeCard(context),
                                        const SizedBox(height: 16),
                                        _buildFirefoxCard(context),
                                      ],
                                    );
                                  }
                                },
                              ),
                              const SizedBox(height: 24),

                              // Coming soon notice
                              Text(
                                'Coming soon to the Chrome Web Store and Firefox Add-ons',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChromeCard(BuildContext context) {
    return _BrowserCard(
      icon: Icons.language,
      label: 'Chrome, Edge & Brave',
      onDownload: () => _launchUrl('/extensions/moxfield-sync-chrome.zip'),
      instructions: [
        const _InstructionStep('Download the zip file'),
        const _InstructionStep(
            'Unzip the file to a folder on your computer'),
        _InstructionStep(
          'Open your browser\'s extension page:',
          copyableLinks: const [
            'chrome://extensions',
            'edge://extensions',
            'brave://extensions',
          ],
        ),
        const _InstructionStep(
            'Enable "Developer mode" (toggle in top-right)'),
        const _InstructionStep(
            'Click "Load unpacked" and select the unzipped folder'),
        const _InstructionStep(
            'Navigate to moxfield.com — the Moxify button appears in the navigation bar'),
      ],
    );
  }

  Widget _buildFirefoxCard(BuildContext context) {
    return _BrowserCard(
      icon: Icons.public,
      label: 'Firefox',
      onDownload: () => _launchUrl('/extensions/moxfield-sync-firefox.zip'),
      instructions: [
        const _InstructionStep('Download the zip file'),
        _InstructionStep(
          'Open the add-ons page in Firefox:',
          copyableLinks: const ['about:addons'],
        ),
        const _InstructionStep(
            'Click the gear icon and select "Install Add-on From File..."'),
        const _InstructionStep('Select the downloaded zip file'),
        const _InstructionStep(
            'Navigate to moxfield.com — the Moxify button appears in the navigation bar'),
      ],
    );
  }
}

class _InstructionStep {
  final String text;
  final List<String> copyableLinks;

  const _InstructionStep(this.text, {this.copyableLinks = const []});
}

class _BrowserCard extends StatelessWidget {
  const _BrowserCard({
    required this.icon,
    required this.label,
    required this.onDownload,
    required this.instructions,
  });

  final IconData icon;
  final String label;
  final VoidCallback onDownload;
  final List<_InstructionStep> instructions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Download'),
            onPressed: onDownload,
            style: FilledButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: Text(
              'Install instructions',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 8),
            children: [
              for (int i = 0; i < instructions.length; i++)
                _buildInstructionRow(context, i, instructions[i]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionRow(
      BuildContext context, int index, _InstructionStep step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${index + 1}.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.text,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                for (final link in step.copyableLinks)
                  _CopyableLink(link: link),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CopyableLink extends StatefulWidget {
  const _CopyableLink({required this.link});

  final String link;

  @override
  State<_CopyableLink> createState() => _CopyableLinkState();
}

class _CopyableLinkState extends State<_CopyableLink> {
  bool _copied = false;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.link));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.link,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 4),
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                onPressed: _copy,
                icon: Icon(
                  _copied ? Icons.check : Icons.copy,
                  size: 14,
                  color: _copied
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                padding: EdgeInsets.zero,
                tooltip: 'Copy to clipboard',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
