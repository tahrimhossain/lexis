import 'package:lexis/Models/Category.dart';

class Categories {
  List<Category>? categories;

  Categories({this.categories});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['Categories'] != null) {
      categories = <Category>[];
      json['Categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

}
