import 'package:lzstring/lzstring.dart';

class ShareLinkHelper {
  // --- PARSE THE URL ---
  static Future<ParsedLoanData?> parseLink(String encodedData) async {
    try {
      final String? rawData = await LZString.decompressFromEncodedURIComponent(encodedData);

      if (rawData == null) return null;

      final parts = rawData.split('|');
      // Basic validation
      if (parts.length < 4) return null;

      List<SimpleCard> parseList(String listStr) {
        if (listStr.isEmpty) return [];
        return listStr.split('~').map((item) {
          final cardParts = item.split('*');
          if (cardParts.length < 3) {
            return SimpleCard(qty: 1, name: 'Unknown', uuid: '');
          }
          return SimpleCard(
            qty: int.tryParse(cardParts[0]) ?? 1,
            name: cardParts[1],
            uuid: cardParts[2],
          );
        }).toList();
      }

      return ParsedLoanData(
        ownerName: parts[0],
        ownerEmoji: parts[1],
        loanedCards: parseList(parts[2]),
        borrowedCards: parseList(parts[3]),
        // Handle optional sender fields if present
        senderName: parts.length > 4 ? parts[4] : null,
        senderEmoji: parts.length > 5 ? parts[5] : null,
      );
    } catch (e) {
      return null;
    }
  }
}

class SimpleCard {
  SimpleCard({
    required this.qty,
    required this.name,
    required this.uuid,
    this.setCode,
    this.imageUrl,
  });
  final int qty;
  final String name;
  final String uuid;
  // We will fill this via Scryfall API later
  String? setCode;
  String? imageUrl;
}

class ParsedLoanData {
  ParsedLoanData({
    required this.ownerName,
    required this.ownerEmoji,
    required this.loanedCards,
    required this.borrowedCards,
    this.senderName,
    this.senderEmoji,
  });
  final String ownerName;
  final String ownerEmoji;
  final List<SimpleCard> loanedCards;
  final List<SimpleCard> borrowedCards;
  final String? senderName;
  final String? senderEmoji;
}
