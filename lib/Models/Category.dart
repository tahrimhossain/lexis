class Category {

  String? categoryName;
  String? categoryId;

  Category({this.categoryName, this.categoryId});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['Category_Name'];
    categoryId = json['Category_Id'];
  }

}