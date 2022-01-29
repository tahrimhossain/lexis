import 'dart:convert';
import 'package:lexis/Models/categories.dart';
import 'package:http/http.dart' as http;


class API{

  Future<Categories> getCategories() async{
    http.Response response = await http.get(Uri.parse('https://lexis-api.herokuapp.com/categories'));
    if(response.statusCode == 200){
      return Categories.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error Fetching Categories');
    }
  }

}