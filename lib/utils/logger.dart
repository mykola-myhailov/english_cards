import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    filter: DevelopmentFilter(),
    output: ConsoleOutput(),
  );
  static const String LOGGER_TAG = 'LOGGER: ';
  static void d(String message) {
    _logger.d(LOGGER_TAG + message);
  }

  static void e(String message) {
    _logger.e(LOGGER_TAG + message);
  }

  static void w(String message) {
    _logger.w(LOGGER_TAG + message);
  }

  static void i(String message) {
    _logger.i(LOGGER_TAG + message);
  }
}