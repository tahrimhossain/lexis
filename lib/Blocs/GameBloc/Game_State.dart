part of 'Game_Bloc.dart';


abstract class GameState {}

class LoadingRoundState extends GameState {}

class GameInProgressState extends GameState{
  int score;
  int currentWordIndex;
  Round round;
  String chosenPattern;
  bool reset;
  List<Pair<String,bool>> jumbledWords;

  GameInProgressState({required this.score,required this.currentWordIndex,required this.round,required this.chosenPattern,required this.reset,required this.jumbledWords}):super();
}


class RoundOverState extends GameState{
  int score;
  RoundOverState({required this.score}):super();

}

class GameOverState extends GameState{
  Word word;
  int score;
  GameOverState({required this.word,required this.score}):super();
}

class ErrorLoadingRoundState extends GameState{

  String categoryId;
  int numberOfWords;
  int ? score;

  ErrorLoadingRoundState({this.score,required this.categoryId,required this.numberOfWords}):super();

}
