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

  WordCardBloc(this._cardsRepository, this._imageRepository){
    _logger.d('WordCardBloc()');
  }

  Stream<WordCardViewModel> get state => _stateController.stream;

  Future<void> fetchData() async {
    _logger.d('fetchData()');
    try {
      final wordCards = await _cardsRepository.fetchCardList();
      _logger.d('Fetched ${wordCards.length} word cards');
      final cardsOrder = await _cardsRepository.getCardsOrder();
      _logger.d('Fetched ${cardsOrder.length} cards order');

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
    _logger.d('_loadCurrentImage()');
    try {
      if (_viewModel.currentWordCard != null) {
        _logger.d('Current cardId: ${_viewModel.currentWordCard!.cardId}');
        final imageUrl = await _imageRepository.getImageUrl(_viewModel.currentWordCard!.imageId);
        _viewModel.setImageUrl(imageUrl);
      } else {
        _logger.d('Current card is null');
      }
    } catch (e) {
      _logger.e('Error loading image: $e');
      _viewModel.setError('Failed to load image');
    }
    _emitState();
  }

  void nextCard() async {
    if (_viewModel.currentIndex < _viewModel.wordCards.length - 1) {
      _viewModel.nextCard();
    } else {
      _viewModel.setIndex(0);
    }
    await _loadCurrentImage();
    _emitState();
  }

  void previousCard() async {
    if (_viewModel.currentIndex > 0) {
      _viewModel.previousCard();
    } else {
      _viewModel.setIndex(_viewModel.wordCards.length - 1);
    }
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