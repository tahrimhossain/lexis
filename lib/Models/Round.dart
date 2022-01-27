import 'package:lexis/Models/Word.dart';

class Round {
  int? numberOfLetters;
  List<Word>? words;

  Round({this.numberOfLetters, this.words});

  Round.fromJson(Map<String, dynamic> json) {
    numberOfLetters = json['NumberOfLetters'];
    if (json['Data'] != null) {
      words = <Word>[];
      json['Data'].forEach((v) {
        words!.add(Word.fromJson(v));
      });
    }
  }

}
