import 'dart:ui';

import 'package:MoxifyMTG/util/share_link_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
// FIX 1: Hide 'Color' to prevent conflict with Flutter's Color class
import 'package:scryfall_api/scryfall_api.dart' hide Color;
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class LoanLandingPage extends StatefulWidget {
  const LoanLandingPage({
    super.key,
    @QueryParam('d') this.importData,
  });
  final String? importData;

  @override
  State<LoanLandingPage> createState() => _LoanLandingPageState();
}

class _LoanLandingPageState extends State<LoanLandingPage> {
  late String backdrop;
  final _apiClient = ScryfallApiClient();

  bool _isLoading = true;
  ParsedLoanData? _data;

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

    _loadData();
  }

  @override
  void dispose() {
    _apiClient.close();
    super.dispose();
  }

  Future<void> _loadData() async {
    if (widget.importData == null) {
      setState(() => _isLoading = false);
      return;
    }

    final data = await ShareLinkHelper.parseLink(widget.importData!);

    if (data != null) {
      await _enrichCards(data);
    }

    if (mounted) {
      setState(() {
        _data = data;
        _isLoading = false;
      });
    }
  }

  Future<void> _enrichCards(ParsedLoanData data) async {
    final allCards = [...data.loanedCards, ...data.borrowedCards];

    // FIX 2: Explicitly type the list as List<String> to avoid dynamic errors
    final List<String> ids =
        allCards.where((c) => c.uuid.isNotEmpty).map((c) => c.uuid).toSet().toList();

    if (ids.isEmpty) return;

    const int chunkSize = 75;
    for (var i = 0; i < ids.length; i += chunkSize) {
      final end = (i + chunkSize < ids.length) ? i + chunkSize : ids.length;
      final List<String> chunk = ids.sublist(i, end);

      try {
        final result = await _apiClient.getCardsByIdentifiers(
          // FIX 3: Use the constructor that matches your scryfall_api version
          chunk.map(CardIdentifierId.new).toList(),
        );

        final map = {for (final c in result.data) c.id: c};

        for (final card in allCards) {
          final scryCard = map[card.uuid];
          if (scryCard != null) {
            card.setCode = scryCard.set.toUpperCase();
          }
        }
      } catch (e) {
        debugPrint('Error fetching scryfall chunk: $e');
      }
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
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Center(
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : _data == null
                    ? const Text(
                        'Invalid Link',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : _buildCardContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    final ownerName = _data!.ownerName;
    final ownerEmoji = _data!.ownerEmoji;
    final senderName = _data!.senderName ?? 'Friend';
    final senderEmoji = _data!.senderEmoji ?? '👤';

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/moxify.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Moxify Loan Tracker',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPlayerProfile(senderEmoji, senderName, 'Source'),
                      const Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 32,
                        color: Colors.grey,
                      ),
                      _buildPlayerProfile(ownerEmoji, ownerName, 'Target'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildListSection(
                          'Borrowed from $ownerName',
                          _data!.borrowedCards,
                          Colors.blue,
                        ),
                      ),
                      const VerticalDivider(width: 32),
                      Expanded(
                        child: _buildListSection(
                          'Loaned to $ownerName',
                          _data!.loanedCards,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Download the app to manage this loan',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  _buildStoreButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerProfile(String emoji, String name, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[100],
          child: Text(
            emoji,
            // FIX: Use GoogleFonts.notoColorEmoji.
            // We remove the explicit 'color' property so the font renders
            // its native colors instead of being tinted/masked.
            style: GoogleFonts.notoColorEmoji(
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<SimpleCard> cards, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // FIX: Removed .toUpperCase() to respect your requested casing
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        if (cards.isEmpty) const Text('-', style: TextStyle(color: Colors.grey)),
        ...cards.map(
          (card) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${card.qty}x ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    card.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                if (card.setCode != null)
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(
                      card.setCode!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreButtons() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: () => launchUrl(
            Uri.parse(
              'https://apps.apple.com/nl/app/moxify-mtg/id6739588255?l=en-GB',
            ),
          ),
          child: SizedBox(
            height: 45,
            width: 135,
            child: SvgPicture.asset('assets/badges/appstore.svg'),
          ),
        ),
        InkWell(
          onTap: () => launchUrl(
            Uri.parse(
              'https://play.google.com/store/apps/details?id=com.bassiuz.moxify',
            ),
          ),
          child: SizedBox(
            height: 45,
            width: 150,
            child: Image.asset('assets/badges/googleplay.png'),
          ),
        ),
      ],
    );
  }
}
