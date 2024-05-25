import 'package:flutter/material.dart';
import '../../models/word_card.dart';
import '../../styles/app_styles.dart';

class WordCardWidget extends StatelessWidget {
  final String? imageUrl;
  final WordCard wordCard;

  const WordCardWidget({
    Key? key,
    this.imageUrl,
    required this.wordCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.cardDecoration,
      padding: const EdgeInsets.all(AppStyles.cardPadding),
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
          const SizedBox(height: AppStyles.spacingHeight16),
          Text(
            wordCard.word,
            style: AppStyles.wordTextStyle,
          ),
          const SizedBox(height: AppStyles.spacingHeight8),
          Text(
            wordCard.translation,
            style: AppStyles.translationTextStyle,
          ),
        ],
      ),
    );
  }
}