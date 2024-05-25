import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/word_card.dart';

class GoogleSheetsService {
  final logger = Logger();
  static const String SPREAD_ID = '1OHbucd34xaY9sXEOq-XOKZcZJ25SZraI3BPZskDjqKI';
  static const String RANGE = 'A2:D6';

  static const String API_KEY = 'AIzaSyAnASAk5qP7VHMnfHfa_ekIjAqz0_IboKA';

  Future<List<WordCard>> getCardList() async {
    logger.d('getCardList()');
    const String SPREADSHEET_URL = 'https://sheets.googleapis.com/v4/spreadsheets/$SPREAD_ID/values/$RANGE?key=$API_KEY';

    Logger().d('Request URL: $SPREADSHEET_URL');
    final response = await http.get(Uri.parse(SPREADSHEET_URL));
    logger.d('Fetching data from Google Sheets...');
    logger.d('Response status code: ${response.statusCode}');
    logger.d('Response body: ${response.body}');


    if (response.statusCode == 200) {
      logger.d('Data successfully fetched from Google Sheets.');
      final Map<String, dynamic> jsonData = json.decode(response.body);
      logger.d('Received JSON data: $jsonData');

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> values = data['values'];
      return values.map((json) => WordCard.fromJson(json)).toList().cast<WordCard>();
    } else {
      logger.e('Failed to load data from Google Sheets.');
      throw Exception('Failed to load data');
    }
  }
}