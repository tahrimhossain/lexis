import 'dart:convert';
import 'package:lexis/Models/category_model.dart';

Categories categoryFromJson(String str) => Categories.fromJson(json.decode(str));

class Categories {
  List<CategoryModel>? categories;

  Categories({this.categories});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['Categories'] != null) {
      categories = <CategoryModel>[];
      json['Categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
  }

}