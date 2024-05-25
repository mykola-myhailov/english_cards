import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final Logger _logger = Logger();

  RemoteConfigService();

  Future<void> initialize() async {
    _logger.d('Initializing Remote Config...');
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      await _remoteConfig.setDefaults(<String, dynamic>{
        'cards_order': '["card_1", "card_2", "card_3", "card_4", "card_5"]',
      });
      _logger.i('Remote Config initialized with default values.');
    } catch (e) {
      _logger.e('Failed to initialize Remote Config. Error: $e');
    }
  }

  Future<void> fetchAndActivate() async {
    _logger.d('Fetching and activating Remote Config...');
    try {
      bool updated = await _remoteConfig.fetchAndActivate();
      if (updated) {
        _logger.d('Remote Config fetched and activated successfully.');
      } else {
        _logger.d('Remote Config fetched but no values were updated.');
      }
    } catch (e) {
      _logger.e('Failed to fetch and activate Remote Config. Error: $e');
    }
  }

  List<String> getCardsOrder() {
    try {
      final jsonString = _remoteConfig.getString('cards_order');
      _logger.d('JSON String: $jsonString');
      _logger.i('Fetched cards_order from Remote Config: $jsonString');

      if (jsonString.isEmpty) {
        _logger.e('cards_order is empty');
        return [];
      }

      final List<dynamic> jsonData = json.decode(jsonString);
      return List<String>.from(jsonData);
    } catch (e) {
      _logger.e('Error fetching cards_order: $e');
      return [];
    }
  }
}