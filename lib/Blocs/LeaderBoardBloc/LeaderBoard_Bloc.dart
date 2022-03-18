import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lexis/Models/LeaderBoard.dart';
import 'package:lexis/Services/API.dart';
import 'package:meta/meta.dart';

part 'LeaderBoard_Event.dart';
part 'LeaderBoard_State.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  final API api;

  LeaderBoardBloc(this.api) : super(LoadingLeaderBoardState()) {
    on<LoadLeaderBoardEvent>((event, emit) async{
      if(state is! LoadingLeaderBoardState){
        emit(LoadingLeaderBoardState());
      }
      try{
        LeaderBoard leaderBoard = await api.getLeaderBoard(event.categoryId);
        emit(LoadedLeaderBoardState(leaderBoard: leaderBoard));
      }catch(e){
        emit(ErrorLoadingLeaderBoardState(categoryId: event.categoryId));
      }
    });
  }
}
