part of 'Game_Bloc.dart';


abstract class GameEvent {}

class LoadRoundEvent extends GameEvent{
  String categoryId;
  int numberOfWords;
  int ? score;

  LoadRoundEvent({this.score,required this.categoryId,required this.numberOfWords}):super();
}

class LetterChosenEvent extends GameEvent{
  int indexOfLetterChosenInJumbledWord;

  LetterChosenEvent({required this.indexOfLetterChosenInJumbledWord}):super();
}

class ResetChosenPattern extends GameEvent{}

class TimeUpEvent extends GameEvent{}