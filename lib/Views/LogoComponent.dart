// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  final String letter;
  final Color color;
  const LogoComponent({Key? key, required this.letter, required this.color}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color
      ),
      child: Center(
        child: Text(letter,
          style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
