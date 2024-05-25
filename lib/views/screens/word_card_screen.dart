import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../bloc/word_card_screen_bloc.dart';
import '../../repositories/cards_repository.dart';
import '../../repositories/image_repository.dart';
import '../../styles/app_styles.dart';
import '../../view_models/word_card_view_model.dart';
import '../widgets/navigatien_button.dart';
import '../widgets/word_card_widget.dart';

class WordCardScreen extends StatelessWidget {
  const WordCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger();
    logger.d('WordCardScreen.build()');
    final cardsRepo = Provider.of<CardsRepository>(context, listen: false);
    final imageRepo = Provider.of<ImageRepository>(context, listen: false);
    final bloc = WordCardBloc(cardsRepo, imageRepo);
    logger.d('Provider create called, calling fetchData');
    bloc.fetchData();

    return Provider<WordCardBloc>.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        body: Center(
          child: StreamBuilder<WordCardViewModel>(
            stream: bloc.state,
            builder: (context, snapshot) {
              final viewModel = snapshot.data;
              if (viewModel == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.error != null) {
                return Center(
                  child: Text(
                    viewModel.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                );
              }

              if (viewModel.wordCards.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * AppStyles.cardMarginTop,
                      horizontal: MediaQuery.of(context).size.width * AppStyles.cardMarginHorizontal,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * AppStyles.cardMaxHeight,
                        minWidth: double.infinity,
                      ),
                      child: AnimatedSwitcher(
                        duration: AppStyles.pageTransitionDuration,
                        switchInCurve: AppStyles.pageTransitionCurve,
                        switchOutCurve: AppStyles.pageTransitionCurve,
                        child: WordCardWidget(
                          key: ValueKey(viewModel.currentWordCard),
                          imageUrl: viewModel.currentImageUrl,
                          wordCard: viewModel.currentWordCard!,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  NavigationButtons(
                    onPrevious: () {
                      bloc.previousCard();
                    },
                    onNext: () {
                      bloc.nextCard();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}