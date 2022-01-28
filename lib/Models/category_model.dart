class CategoryModel {

  String? categoryName;
  String? categoryId;

  CategoryModel({this.categoryName, this.categoryId});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['Category_Name'];
    categoryId = json['Category_Id'];
  }

}