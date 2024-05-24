import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/word_card.dart';

class GoogleSheetsService {
  final logger = Logger();
  static const String SPREADSHEET_URL = 'https://docs.google.com/spreadsheets/d/1OHbucd34xaY9sXEOq-XOKZcZJ25SZraI3BPZskDjqKI/edit?usp=sharing';

  Future<List<WordCard>> getCardList() async {
    final response = await http.get(Uri.parse(SPREADSHEET_URL));
    logger.d('Fetching data from Google Sheets...');

    if (response.statusCode == 200) {
      logger.d('Data successfully fetched from Google Sheets.');

      final Map<String, dynamic> jsonData = json.decode(response.body);
      logger.d('Received JSON data: $jsonData');

      final List<dynamic> rows = jsonData['values'];
      final List<String> headers = rows.removeAt(0).cast<String>();

      final List<WordCard> data = [];
      logger.d('Parsing data from JSON to List of WordCard objects...');
      for (final row in rows) {
        final Map<String, dynamic> rowData = {};
        for (int i = 0; i < row.length; i++) {
          rowData[headers[i]] = row[i];
        }
        data.add(WordCard(
          cardId: rowData['card_id'],
          word: rowData['word'],
          translation: rowData['translation'],
          imageId: rowData['image_id'],
        ));
      }
      logger.d('Data successfully parsed to List of WordCard objects.');

      return data;
    } else {
      logger.e('Failed to load data from Google Sheets.');
      throw Exception('Failed to load data');
    }
  }
}

