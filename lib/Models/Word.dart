import 'package:lexis/Models/Hint.dart';

class Word {
  String ? word;
  List<Hint> ? hints;

  Word({this.word,this.hints});

  Word.fromJson(Map<String, dynamic> json) {
    word = json['Word'];
    if (json['Hints'] != null) {
      hints = <Hint>[];
      json['Hints'].forEach((v) {
        hints!.add(Hint.fromJson(v));
      });
    }
  }

}