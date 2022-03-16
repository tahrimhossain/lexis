part of 'Category_Bloc.dart';


abstract class CategoryEvent {}

class LoadCategoriesEvent extends CategoryEvent{}

class UpdateScoreEvent extends CategoryEvent{
  String categoryId;
  int score;

  UpdateScoreEvent({required this.categoryId,required this.score}):super();
}