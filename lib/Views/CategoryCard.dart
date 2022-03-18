import 'package:lexis/Blocs/CategoryBloc/Category_Bloc.dart';
import 'package:lexis/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:lexis/Views/GameView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Views/LeaderBoardView.dart';



class CategoryCard extends StatefulWidget {

  final Category category;
  const CategoryCard({Key?key,required this.category}):super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();

}

class _CategoryCardState extends State<CategoryCard>{

  @override
  Widget build(BuildContext context) {

    return Container(
      height: (135/812)*MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF00587a),
          boxShadow: const [
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.category.categoryName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height/35,),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LeaderBoardView(categoryId: widget.category.categoryId!,categoryName: widget.category.categoryName!)));
                      },
                      child: const Text("View Leaderboard",style: TextStyle(
                          color: Colors.white70
                      ),)
                  )
                ],
              ),
              //SizedBox(width: (75/375)*MediaQuery.of(context).size.width,),
              Spacer(),
              Container(
                height: (64.45/812)*MediaQuery.of(context).size.height,
                width: (62.5/375)*MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    //color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.category.bestScore.toString(), style: const TextStyle(
                        color: Colors.white,
                    ),),
                    const Text("Best", style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: ()async{
          int ? score = await Navigator.push(context, MaterialPageRoute(builder: (context) => GameView(categoryId: widget.category.categoryId!)));
          if(score != null && score != 0){
            context.read<CategoryBloc>().add(UpdateScoreEvent(score: score, categoryId: widget.category.categoryId!));
          }
        },
      ),
    );
  }
}