part of 'LeaderBoard_Bloc.dart';


abstract class LeaderBoardEvent {}

class LoadLeaderBoardEvent extends LeaderBoardEvent{
  String categoryId;
  LoadLeaderBoardEvent({required this.categoryId}):super();
}

