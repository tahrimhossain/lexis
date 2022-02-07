

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
      width:min(MediaQuery.of(context).size.height,MediaQuery.of(context).size.width)-10,
      height:(min(MediaQuery.of(context).size.height,MediaQuery.of(context).size.width)-10)/(widget.wordLength+0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for(int i = 0; i < widget.wordLength; i++)
            Container(
              width:(min(MediaQuery.of(context).size.height,MediaQuery.of(context).size.width)-10)/(widget.wordLength+0.5),
              height:(min(MediaQuery.of(context).size.height,MediaQuery.of(context).size.width)-10)/(widget.wordLength+0.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < widget.pattern.length? Colors.blue : Colors.white70,
                  border: i < widget.pattern.length ? null : Border.all(
                    color: Colors.blue,
                    width: 2,
                  )
              ),
              child: i < widget.pattern.length ? Center(child: Text(widget.pattern[i],style:TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),):null,
            )
        ],
      ),
    );

  }

}
