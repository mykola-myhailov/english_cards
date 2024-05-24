import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final Logger _logger = Logger();

  RemoteConfigService();

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _remoteConfig.setDefaults(<String, dynamic>{
      'cards_order': '["card_1", "card_2", "card_3", "card_4", "card_5"]',
    });
    _logger.i('Remote Config initialized with default values.');
  }

  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.fetchAndActivate();
      _logger.i('Remote Config fetched and activated.');
    } catch (e) {
      _logger.e('Failed to fetch and activate Remote Config. Error: $e');
    }
  }

  List<String> getCardsOrder() {
    final jsonString = _remoteConfig.getString('cards_order');
    _logger.i('Fetched cards_order from Remote Config: $jsonString');
    return List<String>.from(json.decode(jsonString));
  }
}