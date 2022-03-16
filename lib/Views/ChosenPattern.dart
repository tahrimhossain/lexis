

import 'dart:math';

import 'package:flutter/material.dart';

class ChosenPattern extends StatefulWidget {
  final String pattern;
  final int wordLength;
  const ChosenPattern({Key ? key,required this.pattern,required this.wordLength}):super(key: key);
  @override
  _ChosenPatternState createState() => _ChosenPatternState();
}


class _ChosenPatternState extends State<ChosenPattern> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10,
      height: MediaQuery.of(context).size.height*(10/100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for(int i = 0; i < widget.wordLength; i++)
            Container(
              width:(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/(widget.wordLength+0.5),
              height:(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/(widget.wordLength+0.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < widget.pattern.length? Color(0xFF00587a) : Colors.white70,
                  border: i < widget.pattern.length ? Border.all(color: Colors.white70) : Border.all(
                    color: Colors.white10,
                    width: 2,
                  )
              ),
              child: i < widget.pattern.length ? Center(child: FittedBox(fit: BoxFit.scaleDown,child: Text(widget.pattern[i],style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),),):null,
            )
        ],
      ),
    );

  }

}
