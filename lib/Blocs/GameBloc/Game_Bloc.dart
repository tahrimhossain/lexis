import 'package:bloc/bloc.dart';
import 'package:lexis/Models/Pair.dart';
import 'package:lexis/Models/Round.dart';
import 'package:lexis/Models/Word.dart';
import 'package:lexis/Services/API.dart';


part 'Game_Event.dart';
part 'Game_State.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final API api;


  GameBloc(this.api) : super(LoadingRoundState()) {

    on<LoadRoundEvent>((event, emit)async{

      if(state is! LoadingRoundState){
        emit(LoadingRoundState());
      }

      try{
        Round round = await api.getRound(event.categoryId, event.numberOfWords);
        List<Pair<String,bool>> jumbledWords = [];
        int currentWordIndex = 0;
        for(int i = 0; i < round.words![currentWordIndex].word!.length; i++){
          jumbledWords.add(Pair(first:round.words![currentWordIndex].word![i],second:false));
        }
        jumbledWords.shuffle();
        emit(GameInProgressState(score: event.score ?? 0, currentWordIndex: 0, round: round, chosenPattern: '', reset: true,jumbledWords: jumbledWords));
      }catch(e){
        emit(ErrorLoadingRoundState());
      }
    });

    on<LetterChosenEvent>((event, emit){
      GameInProgressState currentGameState = state as GameInProgressState;
      currentGameState.jumbledWords[event.indexOfLetterChosenInJumbledWord].second = true;
      String updatedChosenPattern = currentGameState.chosenPattern + currentGameState.jumbledWords[event.indexOfLetterChosenInJumbledWord].first;
      if(updatedChosenPattern.length == currentGameState.round.words![currentGameState.currentWordIndex].word!.length){
        if(updatedChosenPattern.compareTo(currentGameState.round.words![currentGameState.currentWordIndex].word!) == 0){
          if(currentGameState.currentWordIndex == currentGameState.round.words!.length-1){
            emit(RoundOverState(score: currentGameState.score+1));
          }else{
            List<Pair<String,bool>> jumbledWords = [];
            int currentWordIndex = currentGameState.currentWordIndex+1;
            for(int i = 0; i < currentGameState.round.words![currentWordIndex].word!.length; i++){
              jumbledWords.add(Pair(first:currentGameState.round.words![currentWordIndex].word![i],second:false));
            }
            jumbledWords.shuffle();
            emit(GameInProgressState(score: currentGameState.score+1, currentWordIndex: currentWordIndex, round: currentGameState.round, chosenPattern: '', reset: true,jumbledWords: jumbledWords));
          }
        }else{
          for(int i = 0; i < currentGameState.jumbledWords.length; i++){
            currentGameState.jumbledWords[i].second = false;
          }

          emit(GameInProgressState(score: currentGameState.score, currentWordIndex: currentGameState.currentWordIndex, round: currentGameState.round, chosenPattern: '', reset: false,jumbledWords: currentGameState.jumbledWords));
        }
      }else{
        emit(GameInProgressState(score: currentGameState.score, currentWordIndex: currentGameState.currentWordIndex, round: currentGameState.round, chosenPattern: updatedChosenPattern, reset: false,jumbledWords: currentGameState.jumbledWords));
      }
    });

    on<ResetChosenPattern>((event, emit){
      GameInProgressState currentGameState = state as GameInProgressState;
      for(int i = 0; i < currentGameState.jumbledWords.length; i++){
        currentGameState.jumbledWords[i].second = false;
      }

      emit(GameInProgressState(score: currentGameState.score, currentWordIndex: currentGameState.currentWordIndex, round: currentGameState.round, chosenPattern: '', reset: false,jumbledWords: currentGameState.jumbledWords));

    });

    on<TimeUpEvent>((event, emit){
      GameInProgressState currentGameState = state as GameInProgressState;
      emit(GameOverState(word: currentGameState.round.words![currentGameState.currentWordIndex], score: currentGameState.score));
    });
  }

}
