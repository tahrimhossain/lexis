class TopScorer {
  String? userId;
  String? name;
  int? score;

  TopScorer({this.userId, this.name, this.score});

  TopScorer.fromJson(Map<String, dynamic> json) {
    userId = json['User_Id'];
    name = json['Name'];
    score = json['Score'];
  }


}