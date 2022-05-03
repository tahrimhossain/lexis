import 'dart:async';
import 'dart:convert';
import 'package:bloc_test/bloc_test.dart';
import 'package:lexis/Blocs/GameBloc/Game_Bloc.dart';
import 'package:lexis/Models/Pair.dart';
import 'package:lexis/Models/Round.dart';
import 'package:lexis/Models/Word.dart';
import 'package:test/test.dart';
import 'package:lexis/Services/API.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httptest;


void main(){

  group(('test GameBloc'),(){
    Future<http.Response> _mockRequest(http.Request request) async {
      if (request.url.toString().startsWith('https://lexis-api.herokuapp.com/categories/')){
        if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/categories/TaGfqJ8phqe1QKnK9TRQmUH3DDl2')){
          return http.Response('{"Categories": [{"Category_Name": "4 letters", "Category_Id": "4", "Best_Score": 22}, {"Category_Name": "5 letters", "Category_Id": "5", "Best_Score": 3}, {"Category_Name": "6 letters", "Category_Id": "6", "Best_Score": 4}, {"Category_Name": "7 letters", "Category_Id": "7", "Best_Score": 0}]}'
              ,200);
        }else{
          return http.Response('{"message": "Invalid uid"}',404);
        }

      }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/highscore/')){

        if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/highscore/4')){
          return http.Response('{"NumberOfLetters": 4, "Top_Scorers": [{"User_Id": "TaGfqJ8phqe1QKnK9TRQmUH3DDl2", "Name": "tahrim", "Score": 22}, {"User_Id": "LypOtvZvRXMTdIQMtuaSwWVXP7b2", "Name": "iamnoobcoder", "Score": 9}, {"User_Id": "QZvRVFKsh3MYgSWeCbkxSDo2zAm2", "Name": "Abul", "Score": 5}, {"User_Id": "5wPODzmFCAYw8G8km1hvID5T1Vy1", "Name": "Rizwan", "Score": 4}, {"User_Id": "7rCNcPh9QaY4SRO432PT91rImXZ2", "Name": "Dudu", "Score": 4}, {"User_Id": "OPTIzDzJopSRmttLPJbjmw7gBez1", "Name": "Rizwan", "Score": 1}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/highscore/5')){
          return http.Response('{"NumberOfLetters": 5, "Top_Scorers": [{"User_Id": "TaGfqJ8phqe1QKnK9TRQmUH3DDl2", "Name": "tahrim", "Score": 3}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/highscore/6')){
          return http.Response('{"NumberOfLetters": 6, "Top_Scorers": [{"User_Id": "TaGfqJ8phqe1QKnK9TRQmUH3DDl2", "Name": "tahrim", "Score": 4}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/highscore/7')){
          return http.Response('{"NumberOfLetters": 7, "Top_Scorers": []}',200);
        }else{
          return http.Response('{"message": "Data not found"}',404);
        }

      }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/')){
        if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/4')){
          return http.Response('{"NumberOfLetters": 4, "Data": [{"Word": "WISH", "Hints": [{"PoS": "Noun", "Meaning": ["a specific feeling of desire", "an expression of some desire or inclination"]}, {"PoS": "Verb", "Meaning": ["feel or express a desire or hope concerning the future or fortune of", "invoke upon"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/5')){
          return http.Response('{"NumberOfLetters": 5, "Data": [{"Word": "ONION", "Hints": [{"PoS": "Noun", "Meaning": ["bulbous plant having hollow leaves cultivated worldwide for its rounded edible bulb", "an aromatic flavorful vegetable"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/6')){
          return http.Response('{"NumberOfLetters": 6, "Data": [{"Word": "IMPOSE", "Hints": [{"PoS": "Verb", "Meaning": ["compel to behave in a certain way"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/7')){
          return http.Response('{"NumberOfLetters": 7, "Data": [{"Word": "STICKER", "Hints": [{"PoS": "Noun", "Meaning": ["a small sharp-pointed tip resembling a spike on a stem or leaf", "an adhesive label"]}]}]}',200);
        }else{
          return http.Response('{"message": "Data not found"}',404);
        }
      }else{
        return http.Response('{"message": "Requested URL not found"}',404);
      }
    }

    API api = API(client: httptest.MockClient(_mockRequest));

    test('initial state is LoadingLeaderBoardState',(){
      expect(GameBloc(api).state,isA<LoadingRoundState>());
    });

    blocTest<GameBloc,GameState>(
        'emits GameInProgressState',
        build:()=> GameBloc(api),
        act: (bloc) => bloc.add(LoadRoundEvent(categoryId: '4', numberOfWords: 1)),
        expect: () => [isA<GameInProgressState>()],
    );

    blocTest<GameBloc,GameState>(
      'emits ErrorLoadingRoundState',
      build:()=> GameBloc(api),
      act: (bloc) => bloc.add(LoadRoundEvent(categoryId: '8', numberOfWords: 1)),
      expect: () => [isA<ErrorLoadingRoundState>()],
    );

    blocTest<GameBloc,GameState>(
      'emits GameInProgressState and then GameOverState',
      build:()=> GameBloc(api),
      act: (bloc) async {
        bloc.add(LoadRoundEvent(categoryId: '4', numberOfWords: 1));
        await Future.delayed(const Duration(seconds: 1));
        bloc.add(TimeUpEvent());
      },
      expect: () => [isA<GameInProgressState>(),isA<GameOverState>()],
    );

    blocTest<GameBloc,GameState>(
      'emits RoundOverState',
      build:()=> GameBloc(api),
      seed:()=> GameInProgressState(score: 0, currentWordIndex: 0, round: Round(numberOfLetters: 4,words:[Word.fromJson(json.decode('{"Word": "WISH", "Hints": [{"PoS": "Noun", "Meaning": ["a specific feeling of desire", "an expression of some desire or inclination"]}, {"PoS": "Verb", "Meaning": ["feel or express a desire or hope concerning the future or fortune of", "invoke upon"]}]}'))]), chosenPattern: 'WIS', reset: false, jumbledWords: [Pair(first: 'I', second:true ),Pair(first: 'W', second:true ),Pair(first: 'H', second:false ),Pair(first: 'S', second:true )]),
      act: (bloc)=> bloc.add(LetterChosenEvent(indexOfLetterChosenInJumbledWord: 2)),
      expect: () => [isA<RoundOverState>()],
    );
    
  });

}