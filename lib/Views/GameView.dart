// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Blocs/GameBloc/Game_Bloc.dart';
import 'package:lexis/Services/API.dart';
import 'ChosenPattern.dart';
import 'FiveLetters.dart';
import 'FourLetters.dart';
import 'SevenLetters.dart';
import 'SixLetters.dart';

class GameView extends StatefulWidget {
  final String categoryId;
  const GameView({Key?key,required this.categoryId}):super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (BuildContext context) => GameBloc(
            RepositoryProvider.of<API>(context)
        )..add(LoadRoundEvent(categoryId: widget.categoryId, numberOfWords:5)),
        child: BlocBuilder<GameBloc,GameState>(
          builder: (context,state){
            if(state is LoadingRoundState){
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else if(state is GameInProgressState){
              return Scaffold(
                body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding:EdgeInsets.only(top:(2.5/100)*MediaQuery.of(context).size.height,bottom:(2.5/100)*MediaQuery.of(context).size.height),
                        child: Column(
                          children: [
                            Container(
                              height:MediaQuery.of(context).size.height*(10/100),
                              width: min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child:MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      minWidth: 20.0,
                                      //color: Colors.blue,
                                      textColor: Colors.blue,
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Column(
                                        children: [
                                          Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.black)),
                                          Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            ChosenPattern(pattern: state.chosenPattern,wordLength: state.jumbledWords.length,),
                            Spacer(),
                            Container(
                              height:MediaQuery.of(context).size.height*(10/100),
                              width: min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width),
                              child: Padding(
                                padding: EdgeInsets.only(left: (20/390)*MediaQuery.of(context).size.width,right: (20/390)*MediaQuery.of(context).size.width),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){},
                                      child: Icon(Icons.help, color: Colors.white),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(20),
                                        primary: Colors.grey,
                                        onPrimary: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    ElevatedButton(
                                      onPressed: (){
                                        context.read<GameBloc>().add(ResetChosenPattern());
                                      },
                                      child: Icon(Icons.refresh, color: Colors.white),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(20),
                                        primary: Colors.grey,
                                        onPrimary: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            if(state.jumbledWords.length == 4)...[
                              FourLetters(jumbledWord: state.jumbledWords)
                            ]else if(state.jumbledWords.length == 5)...[
                              FiveLetters(jumbledWord:state.jumbledWords,)
                            ]else if(state.jumbledWords.length == 6)...[
                              SixLetters(jumbledWord: state.jumbledWords,)
                            ]else...[
                              SevenLetters(jumbledWord: state.jumbledWords,)
                            ]

                          ],
                        ),
                      ),
                    )
                ),
              );
            }else if(state is RoundOverState){
              return Scaffold(
                body: SafeArea(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top:(30/844)*MediaQuery.of(context).size.height,bottom:(30/844)*MediaQuery.of(context).size.height),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.black)),
                                Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:40,color: Colors.black)),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: (20/390)*MediaQuery.of(context).size.width,right: (20/390)*MediaQuery.of(context).size.width),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context,state.score);
                                    },
                                    child: Icon(Icons.home, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      primary: Colors.grey,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: (){
                                      context.read<GameBloc>().add(LoadRoundEvent(categoryId: widget.categoryId, numberOfWords: 5,score: state.score));
                                    },
                                    child: Icon(Icons.play_arrow, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(20),
                                      primary: Colors.grey,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                )
              );
            }else if(state is GameOverState){
              return Scaffold(
                  body: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top:(30/844)*MediaQuery.of(context).size.height,bottom:(30/844)*MediaQuery.of(context).size.height),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text("The correct word is...",style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.black)),
                                  Text(state.word.word!,style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.black)),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.black)),
                                  Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:40,color: Colors.black)),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context,state.score);
                                },
                                child: Icon(Icons.home, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  primary: Colors.grey,
                                  onPrimary: Colors.black,
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                  )
              );

            } else{
              return Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            }
          },
        ),
    );
  }

}