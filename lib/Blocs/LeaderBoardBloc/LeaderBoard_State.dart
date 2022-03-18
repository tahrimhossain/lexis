part of 'LeaderBoard_Bloc.dart';


abstract class LeaderBoardState {}

class LoadingLeaderBoardState extends LeaderBoardState {}

class LoadedLeaderBoardState extends LeaderBoardState {
  LeaderBoard leaderBoard;
  LoadedLeaderBoardState({required this.leaderBoard}):super();
}

class ErrorLoadingLeaderBoardState extends LeaderBoardState {
  String categoryId;
  ErrorLoadingLeaderBoardState({required this.categoryId}):super();
}