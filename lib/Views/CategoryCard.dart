
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:lexis/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:lexis/Views/LogoComponent.dart';

class CategoryCard extends StatefulWidget {

  final Category category;
  CategoryCard(this.category);

  @override
  _CategoryCardState createState() => _CategoryCardState();

}

class _CategoryCardState extends State<CategoryCard>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      child: Container(
        height: MediaQuery.of(context).size.height/6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFF00587a),
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
            child: Text(widget.category.categoryName!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}