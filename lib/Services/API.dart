import 'dart:convert';
import 'package:lexis/Models/LeaderBoard.dart';
import 'package:lexis/Models/Round.dart';
import 'package:lexis/Models/categories.dart';
import 'package:http/http.dart' as http;


class API{

  Future<Categories> getCategories(String uid) async{
    http.Response response = await http.get(Uri.parse('https://lexis-api.herokuapp.com/categories/'+uid));
    if(response.statusCode == 200){
      return Categories.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error Fetching Categories');
    }
  }

  Future updateScore(String uid,String categoryId,int score) async{
    http.Response response = await http.post(Uri.parse('https://lexis-api.herokuapp.com/updatescore/'+categoryId+'/'+uid+'/'+score.toString()));
    if(response.statusCode != 200){
      throw Exception('Error Updating Score');
    }
  }

  Future<Round> getRound(String categoryId,int numberOfWords) async{
    http.Response response = await http.get(Uri.parse('https://lexis-api.herokuapp.com/words/'+categoryId+'/'+numberOfWords.toString()));
    if(response.statusCode == 200){
      return Round.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error Fetching Categories');
    }
  }

  Future<LeaderBoard> getLeaderBoard(String categoryId) async{
    http.Response response = await http.get(Uri.parse('https://lexis-api.herokuapp.com/highscore/'+categoryId));
    if(response.statusCode == 200){
      return LeaderBoard.fromJson(json.decode(response.body));
    }else{
      throw Exception('Error Fetching Leaderboard');
    }
  }
}