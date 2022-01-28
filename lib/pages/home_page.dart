import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lexis/Models/categories.dart';
import 'package:lexis/Models/category_model.dart';
import 'package:lexis/widgets/category_widget.dart';
import 'package:lexis/widgets/name_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> category = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();
  }

  void loadCategory() async {
    var categoryJson = await rootBundle.loadString("assets/files/category.json");
    final categoryAPI = categoryFromJson(categoryJson);
    category = categoryAPI.categories!;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(),
      drawer: Drawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyStyle(letter: "L", myColor: Colors.black87,),
              MyStyle(letter: "E", myColor: Colors.black87,),
              MyStyle(letter: "X", myColor: Colors.black87,),
              MyStyle(letter: "I", myColor: Colors.black87,),
              MyStyle(letter: "S", myColor: Colors.black87,),
            ],
          ),
          SizedBox(height: 36.0,),
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
                  itemCount: category.length,
                  itemBuilder: (context, index){
                    return CategoryWidget(category: category[index]);
                  }
              ),
            ),
          )
        ],
      ),
    );
  }
}
