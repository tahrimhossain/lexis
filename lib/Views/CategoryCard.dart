import 'package:lexis/Blocs/CategoryBloc/Category_Bloc.dart';
import 'package:lexis/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:lexis/Views/GameView.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryCard extends StatefulWidget {

  final Category category;
  const CategoryCard({Key?key,required this.category}):super(key: key);

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.category.categoryName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/35,),
                    TextButton(
                        onPressed: (){},
                        child: Text("View Leaderboard",style: TextStyle(
                          color: Colors.white70
                        ),)
                    )
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/8.5,),
                Container(
                  height: MediaQuery.of(context).size.height/14,
                  width: MediaQuery.of(context).size.width/6.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("10", style: TextStyle(
                        color: Colors.white
                      ),),
                      Text("Best", style: TextStyle(
                        color: Colors.white70
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: ()async{
           int ? score = await Navigator.push(context, MaterialPageRoute(builder: (context) => GameView(categoryId: widget.category.categoryId!)));
           if(score != null){
             context.read<CategoryBloc>().add(UpdateScoreEvent(score: score, categoryId: widget.category.categoryId!));
           }
          },
        ),
      ),
    );
  }
}