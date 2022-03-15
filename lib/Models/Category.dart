class Category {

  String? categoryName;
  String? categoryId;
  int? bestScore;

  Category({this.categoryName, this.categoryId,this.bestScore});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['Category_Name'];
    categoryId = json['Category_Id'];
    bestScore = json['Best_Score'];
  }

}