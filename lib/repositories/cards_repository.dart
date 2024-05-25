import 'package:logger/logger.dart';

import '../models/word_card.dart';
import '../sources/google_sheets.dart';
import '../sources/remote_configs_service.dart';

class CardsRepository {
  final GoogleSheetsService _googleSheetsService = GoogleSheetsService();
  final RemoteConfigService _remoteConfigService = RemoteConfigService();
  Logger logger = Logger();

  Future<List<WordCard>> fetchCardList() async {
    logger.d('fetchCardList()');
    try {
      final cardList = await _googleSheetsService.getCardList();
      return cardList;
    } catch (e) {
      logger.e('fetchCardList() error: $e');
      return [];
    }
  }

  Future<List<String>> getCardsOrder() async {
      await _remoteConfigService.fetchAndActivate();
      return _remoteConfigService.getCardsOrder();
  }
}