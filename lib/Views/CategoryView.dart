// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Blocs/CategoryBloc/Category_Bloc.dart';
import 'package:lexis/Services/API.dart';
import 'package:lexis/Views/LogoComponent.dart';
import 'CategoryCard.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CategoryBloc(
        RepositoryProvider.of<API>(context)
      )..add(LoadCategoriesEvent()),

      child: BlocBuilder<CategoryBloc,CategoryState>(
          builder: (context, state) {
            if(state is LoadingCategoriesState){
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }else if(state is LoadedCategoriesState){
              return Scaffold(
                backgroundColor: Colors.blueGrey,
                appBar: AppBar(),
                drawer: Drawer(),
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        LogoComponent(letter: "L", color: Colors.black87,),
                        LogoComponent(letter: "E", color: Colors.black87,),
                        LogoComponent(letter: "X", color: Colors.black87,),
                        LogoComponent(letter: "I", color: Colors.black87,),
                        LogoComponent(letter: "S", color: Colors.black87,),
                      ],
                    ),
                    SizedBox(height: 3.0,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                            )
                        ),
                        child: ListView.builder(
                            itemCount: state.categories!.categories!.length,
                            itemBuilder: (context, index){
                              return CategoryCard(state.categories!.categories![index]);
                            }
                        ),
                      ),
                    )
                  ],
                ),
              );
            }else{
              return Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
            }
          }
      ),

    );

  }

}
