import 'package:flutter_test/flutter_test.dart';
import 'package:lexis/Models/Categories.dart';
import 'package:lexis/Models/LeaderBoard.dart';
import 'package:lexis/Models/Round.dart';
import 'package:lexis/Services/API.dart';


void main() {
  group(("test API class"),(){

    test(("test getLeaderBoard with valid categoryId"),()async{
      API api = API();
      LeaderBoard leaderBoard = await api.getLeaderBoard('4');
      expect(leaderBoard,isA<LeaderBoard>());
    });

    test(("test getLeaderBoard with invalid categoryId"),()async{
      API api = API();
      expect(()=>api.getLeaderBoard("8"),throwsException);
    });

    test(("test getRound with valid categoryId"),()async{
      API api = API();
      Round round = await api.getRound('4',5);
      expect(round,isA<Round>());
      expect(round.words!.length,5);
    });

    test(("test getRound with invalid categoryId"),()async{
      API api = API();
      expect(()=>api.getRound('8',5),throwsException);
    });

    test(("test getCategories with valid uid"),()async{
      API api = API();
      Categories categories = await api.getCategories("TaGfqJ8phqe1QKnK9TRQmUH3DDl2");
      expect(categories,isA<Categories>());

    });

    test(("test getRound with invalid categoryId"),()async{
      API api = API();
      expect(()=>api.getCategories("TaGfqJ8phqe1QKnK9TRQmUH3DDl"),throwsException);
    });

  });

}