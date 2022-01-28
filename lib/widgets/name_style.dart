import 'package:flutter/material.dart';

class MyStyle extends StatelessWidget {
  final String letter;
  final Color myColor;
  const MyStyle({Key? key, required this.letter, required this.myColor}) : assert(letter != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: myColor
      ),
      child: Center(
        child: Text(letter,
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
