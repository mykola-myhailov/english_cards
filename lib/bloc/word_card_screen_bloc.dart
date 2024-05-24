
import 'dart:async';

import 'package:logger/logger.dart';

import '../models/word_card.dart';
import '../repositories/cards_repository.dart';
import '../repositories/image_repository.dart';
import '../view_models/word_card_view_model.dart';

class WordCardBloc {
  final WordCardViewModel _viewModel = WordCardViewModel();
  final CardsRepository _cardsRepository;
  final ImageRepository _imageRepository;
  final Logger _logger = Logger();
  final StreamController<WordCardViewModel> _stateController = StreamController<WordCardViewModel>.broadcast();

  WordCardBloc(this._cardsRepository, this._imageRepository);

  Stream<WordCardViewModel> get state => _stateController.stream;

  Future<void> fetchData() async {
    try {
      final wordCards = await _cardsRepository.fetchCardList();
      final cardsOrder = await _cardsRepository.getCardsOrder();

      _sortWordCards(wordCards, cardsOrder);
      _viewModel.setWordCards(wordCards);

      await _loadCurrentImage();
    } catch (e) {
      _logger.e('Error fetching data: $e');
      _viewModel.setError('Failed to load data');
    }
    _emitState();
  }

  void _sortWordCards(List<WordCard> wordCards, List<String> cardsOrder) {
    try {
      wordCards.sort((a, b) => cardsOrder.indexOf(a.cardId).compareTo(cardsOrder.indexOf(b.cardId)));
    } catch (e) {
      _logger.d('Error sorting word cards: $e');
    }
  }

  Future<void> _loadCurrentImage() async {
    try {
      if (_viewModel.currentWordCard != null) {
        final imageUrl = await _imageRepository.fetchImageURL(_viewModel.currentWordCard!.imageId);
        _viewModel.setImageUrl(imageUrl);
      }
    } catch (e) {
      _logger.e('Error loading image: $e');
      _viewModel.setError('Failed to load image');
    }
    _emitState();
  }

  void nextCard() async {
    _viewModel.nextCard();
    await _loadCurrentImage();
    _emitState();
  }

  void previousCard() async {
    _viewModel.previousCard();
    await _loadCurrentImage();
    _emitState();
  }

  void _emitState() {
    _stateController.sink.add(_viewModel);
  }

  void dispose() {
    _stateController.close();
  }
}