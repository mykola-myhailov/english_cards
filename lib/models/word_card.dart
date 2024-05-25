class WordCard {
  final String cardId;
  final String word;
  final String translation;
  final String imageId;


  WordCard({
    required this.cardId,
    required this.word,
    required this.translation,
    required this.imageId,
  });

  static fromJson(json) {
    return WordCard(
      cardId: json[0],
      word: json[1],
      translation: json[2],
      imageId: json[3],
    );
  }
}