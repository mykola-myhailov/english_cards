import 'package:flutter/material.dart';
import '../../models/word_card.dart';
import '../../styles/app_styles.dart';

class WordCardWidget extends StatelessWidget {
  final String? imageUrl;
  final WordCard wordCard;

  const WordCardWidget({
    super.key,
    this.imageUrl,
    required this.wordCard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppStyles.cardPadding),
      child: Container(
        decoration: AppStyles.cardDecoration,
        padding: const EdgeInsets.all(AppStyles.cardPadding),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl != null)
              Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                height: AppStyles.imageHeight,
                width: AppStyles.imageWidth,
              ),
            const SizedBox(height: AppStyles.spacingHeight40),
            Text(
              wordCard.word,
              style: AppStyles.wordTextStyle,
            ),
            const SizedBox(height: AppStyles.spacingHeight20),
            Text(
              wordCard.translation,
              style: AppStyles.translationTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
