part of 'Category_Bloc.dart';


abstract class CategoryState {}

class LoadingCategoriesState extends CategoryState {}

class LoadedCategoriesState extends CategoryState{
   Categories ? categories;
   LoadedCategoriesState({required this.categories}):super();
}

class ErrorLoadingCategoriesState extends CategoryState{}
