import 'package:flutter/material.dart';

class AppStyles {
  static const double cardPadding = 16.0;
  static const double spacingHeight32 = 32.0;
  static const double spacingHeight16 = 16.0;
  static const double spacingHeight8 = 8.0;

  static double get cardMarginTop => 0.01;
  static double get cardMarginBottom => 0.05;
  static double get cardMarginHorizontal => 0.05;

  static const double imageHeight = 200.0;
  static const double imageWidth = 200.0;

  static double get buttonHeight => 0.08;
  static double get buttonWidth => 0.4;
  static const double buttonSpacing = 16.0;

  static double get cardMaxHeight => 0.6;
  static const Duration pageTransitionDuration = Duration(milliseconds: 500);
  static const Curve pageTransitionCurve = Curves.easeInOut;

  static const TextStyle wordTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle translationTextStyle = TextStyle(
    fontSize: 24,
    color: Colors.white,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const BoxDecoration cardDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/ui_block.png'),
      fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.all(Radius.circular(16)),
  );

  static const BoxDecoration backButtonDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/ui_button_back.png'),
      fit: BoxFit.contain,
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const BoxDecoration nextButtonDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/ui_button_next.png'),
      fit: BoxFit.contain,
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const Color backgroundColor = Color(0xFF1C1C1E);
}