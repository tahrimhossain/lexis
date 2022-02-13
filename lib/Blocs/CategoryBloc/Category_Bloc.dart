import 'package:bloc/bloc.dart';
import 'package:lexis/Models/categories.dart';
import 'package:lexis/Services/API.dart';
part  'Category_Event.dart';
part 'Category_State.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final API api;

  CategoryBloc(this.api) : super(LoadingCategoriesState()) {

    on<LoadCategoriesEvent>((event, emit) async{
      emit(LoadingCategoriesState());
      try{
        Categories categories = await api.getCategories();
        emit(LoadedCategoriesState(categories: categories));
      }catch(e){
        emit(ErrorLoadingCategoriesState());
      }

    });
  }
}
