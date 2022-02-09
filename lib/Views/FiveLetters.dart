
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lexis/Blocs/GameBloc/Game_Bloc.dart';
import 'package:lexis/Models/Pair.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FiveLetters extends StatefulWidget{
  final List<Pair<String,bool>> jumbledWord;
  const FiveLetters({Key?key,required this.jumbledWord}):super(key: key);
  @override
  _FiveLettersState createState() => _FiveLettersState();
}

class _FiveLettersState extends State<FiveLetters> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync:this,duration:const Duration(seconds: 20))..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        context.read<GameBloc>().add(TimeUpEvent());
      }
    });
    animation = Tween<double>(begin: 1, end: 0).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<GameBloc,GameState>(
      listener:(context,state){
        if(state is GameInProgressState){
          if(state.reset == true){
            animationController.reset();
            animationController.forward();
          }else{
            animationController.forward();
          }
        }
      },

      child: Container(
          width: min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10,
          height: min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10,
          child: Stack(
            fit: StackFit.expand,
            children: [

              AnimatedBuilder(
                  animation: animationController,

                  builder:(context,value){
                    return CircularProgressIndicator(
                      value: animation.value,
                    );
                  }
              ),

              //left
              Positioned(
                  top: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),
                  left: (5/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),

                  child:GestureDetector(
                    child: Container(
                        width: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        height: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.jumbledWord[0].second == false ? Colors.blue : Colors.grey
                        ),
                        child:Center(child: Text(widget.jumbledWord[0].first,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),)
                    ),
                    onTap: (){
                      GameInProgressState currentState = context.read<GameBloc>().state as GameInProgressState;
                      if(currentState.jumbledWords[0].second == false){
                        animationController.stop();
                        context.read<GameBloc>().add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 0));
                      }
                    },
                  )
              ),

              //top
              Positioned(
                  top: (5/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                  left: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),

                  child:GestureDetector(
                    child: Container(
                        width: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        height: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.jumbledWord[1].second == false ? Colors.blue : Colors.grey
                        ),
                        child:Center(child: Text(widget.jumbledWord[1].first,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),)
                    ),
                    onTap: (){
                      GameInProgressState currentState = context.read<GameBloc>().state as GameInProgressState;
                      if(currentState.jumbledWords[1].second == false){
                        animationController.stop();
                        context.read<GameBloc>().add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 1));
                      }
                    },
                  )
              ),

              //right
              Positioned(
                  top: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),
                  right: (5/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),

                  child:GestureDetector(
                    child: Container(
                        width: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        height: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.jumbledWord[2].second == false ? Colors.blue : Colors.grey
                        ),
                        child:Center(child: Text(widget.jumbledWord[2].first,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),)
                    ),
                    onTap: (){
                      GameInProgressState currentState = context.read<GameBloc>().state as GameInProgressState;
                      if(currentState.jumbledWords[2].second == false){
                        animationController.stop();
                        context.read<GameBloc>().add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 2));
                      }
                    },
                  )
              ),

              //bottom
              Positioned(
                  bottom: (5/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                  left: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),

                  child:GestureDetector(
                    child: Container(
                        width: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        height: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.jumbledWord[3].second == false ? Colors.blue : Colors.grey
                        ),
                        child:Center(child: Text(widget.jumbledWord[3].first,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),)
                    ),
                    onTap: (){
                      GameInProgressState currentState = context.read<GameBloc>().state as GameInProgressState;
                      if(currentState.jumbledWords[3].second == false){
                        animationController.stop();
                        context.read<GameBloc>().add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 3));
                      }
                    },
                  )
              ),

              //middle
              Positioned(
                  top: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),
                  left: ((min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10)/2)-(((80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10))/2),

                  child:GestureDetector(
                    child: Container(
                        width: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        height: (80/260)*(min(MediaQuery.of(context).size.height*(65/100),MediaQuery.of(context).size.width)-10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.jumbledWord[4].second == false ? Colors.blue : Colors.grey
                        ),
                        child:Center(child: Text(widget.jumbledWord[4].first,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30,color: Colors.white)),)
                    ),
                    onTap: (){
                      GameInProgressState currentState = context.read<GameBloc>().state as GameInProgressState;
                      if(currentState.jumbledWords[4].second == false){
                        animationController.stop();
                        context.read<GameBloc>().add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 4));
                      }
                    },
                  )
              ),
            ],
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            //color: Colors.red

          )
      ),

    );

  }

}