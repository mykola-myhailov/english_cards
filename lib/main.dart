import 'package:english_cards/repositories/cards_repository.dart';
import 'package:english_cards/repositories/image_repository.dart';
import 'package:english_cards/views/screens/word_card_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

void main() async {
  Logger logger = Logger();
  logger.d('main()');
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('WidgetsFlutterBinding.ensureInitialized()');
  await Firebase.initializeApp();
  logger.d('Firebase.initializeApp()');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CardsRepository>(create: (_) => CardsRepository()),
        Provider<ImageRepository>(create: (_) => ImageRepository()),
      ],
      child: MaterialApp(
        title: 'Word Cards',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WordCardScreen(),
      ),
    );
  }
}




