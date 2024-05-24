import '../models/word_card.dart';

class WordCardViewModel {
  List<WordCard> _wordCards = [];
  int _currentIndex = 0;
  String? _currentImageUrl;
  String? _error;

  List<WordCard> get wordCards => _wordCards;
  String? get currentImageUrl => _currentImageUrl;
  WordCard? get currentWordCard => _wordCards.isNotEmpty ? _wordCards[_currentIndex] : null;
  int get currentIndex => _currentIndex;
  String? get error => _error;

  void setWordCards(List<WordCard> wordCards) {
    _wordCards = wordCards;
    _error = null;
  }

  void setImageUrl(String? imageUrl) {
    _currentImageUrl = imageUrl;
    _error = null;
  }

  void setError(String error) {
    _error = error;
  }

  void nextCard() {
    if (_currentIndex < _wordCards.length - 1) {
      _currentIndex++;
    }
  }

  void previousCard() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
  }
}