part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}


class GetRecipesPopularLoading extends AppState {}
class GetRecipesPopularSucceeded extends AppState {}
class GetRecipesPopularFailed extends AppState {}



class GetRecipesNewLoading extends AppState {}
class GetRecipesNewSucceeded extends AppState {}
class GetRecipesNewFailed extends AppState {}



class GetCategoriesLoading extends AppState {}
class GetCategoriesSucceeded extends AppState {}
class GetCategoriesFailed extends AppState {}



class GetCategoryDetailsLoading extends AppState {}
class GetCategoryDetailsSucceeded extends AppState {}
class GetCategoryDetailsFailed extends AppState {}



class GetRecipesComponentsLoading extends AppState {}
class GetRecipesComponentsSucceeded extends AppState {}
class GetRecipesComponentsFailed extends AppState {}


class MyLoaded extends AppState {
  final Map<String, dynamic> recipeComponent;

   MyLoaded(this.recipeComponent);

  @override
  List<Object> get props => [recipeComponent];
}

class MyError extends AppState {
  final String error;

  MyError(this.error);
}