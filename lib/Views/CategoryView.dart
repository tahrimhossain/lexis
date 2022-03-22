// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Blocs/AuthenticationBloc/Authentication_Bloc.dart';
import 'package:lexis/Blocs/CategoryBloc/Category_Bloc.dart';
import 'package:lexis/Services/API.dart';
import 'package:lexis/Services/Authentication.dart';
import 'package:lexis/Views/LogoComponent.dart';
import 'CategoryCard.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CategoryBloc(
        RepositoryProvider.of<API>(context),RepositoryProvider.of<Authentication>(context)
      )..add(LoadCategoriesEvent()),

      child: BlocBuilder<CategoryBloc,CategoryState>(
          builder: (context, state) {
            if(state is LoadingCategoriesState){
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else if(state is LoadedCategoriesState){
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                appBar: AppBar(),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text("LogOut"),
                        onTap: (){
                          context.read<AuthenticationBloc>().add(LogOutRequestEvent());
                        },
                      )
                    ],
                  ),
                ),
                body: DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          LogoComponent(letter: "L", color: Color(0xFFb786f7),),
                          LogoComponent(letter: "E", color: Color(0xFFd95959),),
                          LogoComponent(letter: "X", color: Color(0xFF18c94d),),
                          LogoComponent(letter: "I", color: Color(0xFFe8ca05),),
                          LogoComponent(letter: "S", color: Color(0xFFf28ad6),),
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)
                              )
                          ),
                          child: ListView.separated(
                              itemCount: state.categories!.categories!.length,
                              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 17),
                              itemBuilder: (context, index){
                                return CategoryCard(category: state.categories!.categories![index],);
                              },
                              separatorBuilder:(context,index){
                                return SizedBox(height: 30,);
                              } ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else if(state is ErrorUpdatingScoreState){
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Something went wrong!",style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),),
                      ElevatedButton(onPressed:(){
                        context.read<CategoryBloc>().add(UpdateScoreEvent(score: state.score, categoryId: state.categoryId));
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
            } else{
              return Scaffold(
                backgroundColor: Color(0xFF283048),
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Something went wrong!",style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20, color: Colors.white),),
                        ElevatedButton(onPressed:(){
                          context.read<CategoryBloc>().add(LoadCategoriesEvent());
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
            }
          }
      ),

    );

  }

}
