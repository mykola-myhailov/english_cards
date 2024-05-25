import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const NavigationButtons({
    super.key,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Padding(
      padding: EdgeInsets.only(
        bottom: screenHeight * AppStyles.cardMarginBottom, // Отступ снизу
        left: screenWidth * AppStyles.cardMarginHorizontal,
        right: screenWidth * AppStyles.cardMarginHorizontal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onPrevious,
            child: Container(
              decoration: AppStyles.backButtonDecoration,
              height: screenHeight * AppStyles.buttonHeight,
              width: screenWidth * AppStyles.buttonWidth,
              alignment: Alignment.center,
              child: const Text(
                'Back',
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
          const SizedBox(width: AppStyles.buttonSpacing),
          GestureDetector(
            onTap: onNext,
            child: Container(
              decoration: AppStyles.nextButtonDecoration,
              height: screenHeight * AppStyles.buttonHeight,
              width: screenWidth * AppStyles.buttonWidth,
              alignment: Alignment.center,
              child: const Text(
                'Next',
                style: AppStyles.buttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}