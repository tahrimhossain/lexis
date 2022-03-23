// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  bool popUpOpen = false;

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
        create: (BuildContext context) => GameBloc(
            RepositoryProvider.of<API>(context)
        )..add(LoadRoundEvent(categoryId: widget.categoryId, numberOfWords:5)),
        child: BlocConsumer<GameBloc,GameState>(
          listener: (context, state) {
            if(state is! GameInProgressState && popUpOpen == true){
              Navigator.pop(context);
            }
          },
          builder: (context,state){
            if(state is ErrorLoadingRoundState){
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                backgroundColor: Color(0xFF283048),
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Something went wrong!",style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),),
                        ElevatedButton(onPressed:(){
                          context.read<GameBloc>().add(LoadRoundEvent(categoryId: state.categoryId, numberOfWords: state.numberOfWords,score: state.score));
                        },
                          child: Text("Retry"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF00587a),
                          ),

                        )
                      ],
                    )
                ),
              );

            }else if(state is GameInProgressState){
              return Scaffold(
                backgroundColor: Color(0xFF283048),
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
                                      textColor: Colors.white,
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
                                          Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),
                                          Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white)),
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
                                      onPressed: (){
                                        popUpOpen = true;
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: (){
                                                  Navigator.of(context).pop();
                                                },
                                                child: DraggableScrollableSheet(
                                                  initialChildSize: 0.3,
                                                  minChildSize: 0.3,
                                                  maxChildSize: 0.6,
                                                  builder: (BuildContext context, ScrollController scrollController) => Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
                                                    ),
                                                    padding: EdgeInsets.all(16.0),
                                                    child: ListView.builder(
                                                      controller: scrollController,
                                                      itemCount: state.round.words![state.currentWordIndex].hints!.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("     ${state.round.words![state.currentWordIndex].hints![index].poS}",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold
                                                              )
                                                            ),
                                                            SizedBox(height: 5,),
                                                            ListView.builder(
                                                                shrinkWrap: true,
                                                                physics: ClampingScrollPhysics(),
                                                                itemCount: state.round.words![state.currentWordIndex].hints![index].meanings!.length,
                                                                itemBuilder: (BuildContext context, int index2){
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Icon(CupertinoIcons.arrowshape_turn_up_right, size: 15),
                                                                          SizedBox(width: 5,),
                                                                          Flexible(
                                                                            child: Text(state.round.words![state.currentWordIndex].hints![index].meanings![index2],
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 8,)
                                                                    ],
                                                                  );
                                                                }),
                                                            SizedBox(height: 14,),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  ),
                                                ),
                                              );
                                            }).whenComplete((){
                                              popUpOpen = false;

                                        });
                                      },
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
              return WillPopScope(
                  child: Scaffold(
                  backgroundColor: Color(0xFF283048),
                  body: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top:(30/844)*MediaQuery.of(context).size.height,bottom:(30/844)*MediaQuery.of(context).size.height),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.white)),
                                  Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:40,color: Colors.white)),
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
              ),
                  onWillPop:() async => false
              );
            }else if(state is GameOverState){
              return WillPopScope(
                  child: Scaffold(
                  backgroundColor: Color(0xFF283048),
                  body: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top:(30/844)*MediaQuery.of(context).size.height,bottom:(30/844)*MediaQuery.of(context).size.height),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text("The correct word is...",style:TextStyle(fontWeight: FontWeight.bold,fontSize:20,color: Colors.white)),
                                  Text(state.word.word!,style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.white)),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text("Score",style:TextStyle(fontWeight: FontWeight.bold,fontSize:70,color: Colors.white)),
                                  Text(state.score.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize:40,color: Colors.white)),
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
              ),
                  onWillPop: () async => false
              );

            } else{
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
    );
  }

}