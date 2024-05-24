import '../models/word_card.dart';
import '../sources/google_sheets.dart';
import '../sources/remote_configs_service.dart';

class CardsRepository {
  final GoogleSheetsService _googleSheetsService = GoogleSheetsService();
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

  Future<List<WordCard>> fetchCardList() async {
    try {
      final cardList = await _googleSheetsService.getCardList();
      return cardList;
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getCardsOrder() async {
      await _remoteConfigService.fetchAndActivate();
      return _remoteConfigService.getCardsOrder();
  }
}