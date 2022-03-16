import 'package:bloc/bloc.dart';
import 'package:lexis/Models/CustomUser.dart';
import 'package:lexis/Models/categories.dart';
import 'package:lexis/Services/API.dart';
import 'package:lexis/Services/Authentication.dart';
part  'Category_Event.dart';
part 'Category_State.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final API api;
  final Authentication authentication;

  CategoryBloc(this.api,this.authentication) : super(LoadingCategoriesState()) {

    on<LoadCategoriesEvent>((event, emit) async{
      emit(LoadingCategoriesState());
      try{
        CustomUser? user = authentication.getCurrentUser();
        Categories categories = await api.getCategories(user!.id);
        emit(LoadedCategoriesState(categories: categories));
      }catch(e){
        emit(ErrorLoadingCategoriesState());
      }

    });

    on<UpdateScoreEvent>((event, emit) async{
      emit(LoadingCategoriesState());
      try{
        CustomUser? user = authentication.getCurrentUser();
        await api.updateScore(user!.id,event.categoryId,event.score);
        Categories categories = await api.getCategories(user.id);
        emit(LoadedCategoriesState(categories: categories));
      }catch(e){
        emit(ErrorUpdatingScoreState(categoryId: event.categoryId, score: event.score));
      }
    });
  }
}
