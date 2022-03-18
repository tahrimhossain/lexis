import 'TopScorer.dart';

class LeaderBoard {
  int? numberOfLetters;
  List<TopScorer>? topScorers;

  LeaderBoard({this.numberOfLetters, this.topScorers});

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    numberOfLetters = json['NumberOfLetters'];
    if (json['Top_Scorers'] != null) {
      topScorers = <TopScorer>[];
      json['Top_Scorers'].forEach((v) {
        topScorers!.add(TopScorer.fromJson(v));
      });
    }
  }

}