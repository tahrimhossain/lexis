import 'package:flutter/material.dart';
import 'package:lexis/Models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  const CategoryWidget({Key? key, required this.category}) : assert(category != null),super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.lightBlue,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(5.0, 5.0),
              blurRadius: 2.0,
              spreadRadius: 0.0
            )
          ]
        ),
        child: ListTile(
          title: Center(
            child: Text(category.categoryName!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            ),
          ),
        ),
      ),
    );
  }
}