class Hint {
  String? poS;
  List<String>? meanings;

  Hint({this.poS, this.meanings});

  Hint.fromJson(Map<String, dynamic> json) {
    poS = json['PoS'];
    meanings = json['Meaning'].cast<String>();
  }

}
