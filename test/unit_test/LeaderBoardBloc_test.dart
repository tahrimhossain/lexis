import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:lexis/Blocs/LeaderBoardBloc/LeaderBoard_Bloc.dart';
import 'package:test/test.dart';
import 'package:lexis/Services/API.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' as httptest;


void main(){

  group(('test LeaderBoardBloc'),(){
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
          return http.Response('{"NumberOfLetters": 4, "Data": [{"Word": "WISH", "Hints": [{"PoS": "Noun", "Meaning": ["a specific feeling of desire", "an expression of some desire or inclination"]}, {"PoS": "Verb", "Meaning": ["feel or express a desire or hope concerning the future or fortune of", "invoke upon"]}]}, {"Word": "ASKS", "Hints": [{"PoS": "Verb", "Meaning": ["make a request or demand for something to somebody", "direct or put; seek an answer to"]}]}, {"Word": "MEAN", "Hints": [{"PoS": "Noun", "Meaning": ["an average of n numbers computed by adding some function of the numbers and dividing by some function of n"]}, {"PoS": "Verb", "Meaning": ["have as a logical consequence", "denote or connote"]}, {"PoS": "Adjective", "Meaning": ["approximating the statistical norm or average or expected value", "characterized by malice"]}]}, {"Word": "HOLE", "Hints": [{"PoS": "Noun", "Meaning": ["an opening into or through something", "an opening deliberately made in or through something"]}]}, {"Word": "CURE", "Hints": [{"PoS": "Verb", "Meaning": ["prepare by drying, salting, or chemical processing in order to preserve", "make (substances"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/5')){
          return http.Response('{"NumberOfLetters": 5, "Data": [{"Word": "ONION", "Hints": [{"PoS": "Noun", "Meaning": ["bulbous plant having hollow leaves cultivated worldwide for its rounded edible bulb", "an aromatic flavorful vegetable"]}]}, {"Word": "ALIGN", "Hints": [{"PoS": "Verb", "Meaning": ["place in a line or arrange so as to be parallel or straight", "be or come into adjustment with"]}]}, {"Word": "STOPS", "Hints": [{"PoS": "Noun", "Meaning": ["the event of something ending", "the act of stopping something"]}, {"PoS": "Verb", "Meaning": ["come to a halt, stop moving", "put an end to a state or an activity"]}]}, {"Word": "HAIRY", "Hints": [{"PoS": "Adjective", "Meaning": ["having or covered with hair", "hazardous and frightening"]}]}, {"Word": "LIKES", "Hints": [{"PoS": "Noun", "Meaning": ["a similar kind", "a kind of person"]}, {"PoS": "Verb", "Meaning": ["prefer or wish to do something", "find enjoyable or agreeable"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/6')){
          return http.Response('{"NumberOfLetters": 6, "Data": [{"Word": "IMPOSE", "Hints": [{"PoS": "Verb", "Meaning": ["compel to behave in a certain way"]}]}, {"Word": "BUREAU", "Hints": [{"PoS": "Noun", "Meaning": ["an administrative unit of government", "furniture with drawers for keeping clothes"]}]}, {"Word": "RESULT", "Hints": [{"PoS": "Noun", "Meaning": ["a phenomenon that follows and is caused by some previous phenomenon", "a statement that solves a problem or explains how to solve the problem"]}, {"PoS": "Verb", "Meaning": ["issue or terminate (in a specified way, state, etc.", "come about or follow as a consequence"]}]}, {"Word": "RIDING", "Hints": [{"PoS": "Noun", "Meaning": ["the sport of sitting on the back of a horse while controlling its movements", "travel by being carried on horseback"]}, {"PoS": "Verb", "Meaning": ["sit and travel on the back of animal, usually while controlling its motions", "be carried or travel on or in a vehicle"]}]}, {"Word": "SUITES", "Hints": [{"PoS": "Noun", "Meaning": ["a musical composition of several movements only loosely connected", "apartment consisting of a series of connected rooms used as a living unit (as in a hotel"]}]}]}',200);
        }else if(request.url.toString().startsWith('https://lexis-api.herokuapp.com/words/7')){
          return http.Response('{"NumberOfLetters": 7, "Data": [{"Word": "STICKER", "Hints": [{"PoS": "Noun", "Meaning": ["a small sharp-pointed tip resembling a spike on a stem or leaf", "an adhesive label"]}]}, {"Word": "STRETCH", "Hints": [{"PoS": "Noun", "Meaning": ["a large and unbroken expanse or distance", "the act of physically reaching or thrusting out"]}, {"PoS": "Verb", "Meaning": ["occupy a large, elongated area", "extend one\'s limbs or muscles, or the entire body"]}, {"PoS": "Adjective", "Meaning": ["having an elongated seating area"]}]}, {"Word": "RESPOND", "Hints": [{"PoS": "Verb", "Meaning": ["show a response or a reaction to something", "react verbally"]}]}, {"Word": "JAMAICA", "Hints": [{"PoS": "Noun", "Meaning": ["a country on the island of Jamaica; became independent of England in 1962; much poverty; the major industry is tourism", "an island in the West Indies to the south of Cuba and to the west of Haiti"]}]}, {"Word": "VICTIMS", "Hints": [{"PoS": "Noun", "Meaning": ["an unfortunate person who suffers from some adverse circumstance", "a person who is tricked or swindled"]}]}]}',200);
        }else{
          return http.Response('{"message": "Data not found"}',404);
        }
      }else{
        return http.Response('{"message": "Requested URL not found"}',404);
      }
    }

    API api = API(client: httptest.MockClient(_mockRequest));

    test('initial state is LoadingLeaderBoardState',(){
      expect(LeaderBoardBloc(api).state,isA<LoadingLeaderBoardState>());
    });

    blocTest<LeaderBoardBloc,LeaderBoardState>(
      'emits LoadedLeaderBoardState',
      build:()=>LeaderBoardBloc(api),
      act: (bloc) => bloc.add(LoadLeaderBoardEvent(categoryId: '4')),
      expect: () => [isA<LoadedLeaderBoardState>()]
    );

    blocTest<LeaderBoardBloc,LeaderBoardState>(
        'emits ErrorLoadingLeaderBoardState',
        build:()=>LeaderBoardBloc(api),
        act: (bloc) => bloc.add(LoadLeaderBoardEvent(categoryId: '8')),
        expect: () => [isA<ErrorLoadingLeaderBoardState>()]
    );
  });

}