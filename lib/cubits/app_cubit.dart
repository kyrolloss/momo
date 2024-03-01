import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo/helper/dio/Dio%20Helper.dart';
import 'package:momo/helper/dio/end%20points/end%20points.dart';
import 'package:momo/models/Categories%20Details/Categories%20Details.dart';
import 'package:momo/models/Categories/Categories.dart';
import 'package:momo/models/Recipes%20components/Recipes%20components.dart';

import '../models/New Recipes/New Recipes.dart';
import '../models/Popular Recipes/Popular Recipes model.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {

  static AppCubit get(context) => BlocProvider.of(context);


  AppCubit() : super(AppInitial());
  List <PopularRecipes>popularRecipes = [];
  List <NewRecipes> newRecipes = [];
  List <Categories>  categories = [];
  List <Categoriesdetails> categoryDetails = [];

  int page = 1;




  Future<void>getPopularRecipe()async{
    emit(GetRecipesPopularLoading());
    await DioHelper.getRecipes(
        endPoint: EndPoint.popularRecipe,


    ).then((value) {
      var json = value.data;

      json.forEach((element) {
        PopularRecipes recipes = PopularRecipes.fromJson(element);

        popularRecipes.insert(popularRecipes.length, recipes);

      });
      emit(GetRecipesPopularSucceeded());
      print(popularRecipes.first.toJson());

    }).catchError((error){
      print(error.toString());
      emit(GetRecipesPopularFailed());
    });


  }

  Future<void>getNewRecipe()async{
    emit(GetRecipesNewLoading());
    await DioHelper.getRecipes(
      endPoint: EndPoint.NewRecipe,


    ).then((value) {
      var json = value.data;

      json.forEach((element) {
        NewRecipes recipes = NewRecipes.fromJson(element);

        newRecipes.add(recipes);

      });
      emit(GetRecipesNewSucceeded());


    }).catchError((error){
      print(error.toString());
      emit(GetRecipesNewFailed());
    });


  }

  Future<void>getCategories()async{
    emit(GetCategoriesLoading());
    await DioHelper.getRecipes(
      endPoint: EndPoint.Categories,


    ).then((value) {
      var json = value.data;

      json.forEach((element) {
        Categories category = Categories.fromJson(element);

        categories.add(category);

      });
      emit(GetCategoriesSucceeded());


    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesFailed());
    });


  }

  Future<void>getCategoryDetails({int? page  ,String? path})async{
    emit(GetCategoryDetailsLoading());
    await DioHelper.CategoryDetails(
      endPoint: EndPoint.CategoriesDetails, page: page == null ? 1 :page, path: path == null ? '/Recetas-de-Verduras-listado_receta-7_1.html' : path



    ).then((value) {
      var json = value.data;

      json.forEach((element) {
        Categoriesdetails category = Categoriesdetails.fromJson(element);

        categoryDetails.add(category);

      });
      emit(GetCategoryDetailsSucceeded());


    }).catchError((error){
      print(error.toString());
      emit(GetCategoryDetailsFailed());
    });


  }
  late RecipeModel recipeModel = RecipeModel();

  Future <void>getRecipeDetails(String? path) async {
    emit(GetRecipesComponentsLoading());
    try {
      var response = await DioHelper.getRecipesComponents(
        Path:path == null ? '/Recetas-de-Verduras-listado_receta-7_1.html' : path,
        endPoint: EndPoint.RecipesDetails
      );
      recipeModel =  RecipeModel.fromJson(response);
      emit(GetRecipesComponentsSucceeded());
    } catch (error) {
      print(error.toString());
      emit(GetRecipesComponentsFailed());
      print('error here');

    }
  }


}

  // Future<void>getRecipeComponents({required String Path})async{
  //   emit(GetRecipesComponentsLoading());
  //
  //   await DioHelper.getRecipesComponents(
  //     endPoint: EndPoint.RecipesDetails, path: 'receta-de-albondigas-de-carne-molida-45979.html',
  //
  //
  //
  //
  //   ).then((value) {
  //     var json = value.data;
  //
  //     json.forEach((element) {
  //       RecipesComponent recipes = RecipesComponent.fromJson(element);
  //
  //       recipesComponents.add(element);
  //
  //     });
  //     emit(GetRecipesComponentsSucceeded());
  //
  //   }).catchError((error){
  //     print(error.toString());
  //     print('here');
  //     emit(GetRecipesComponentsFailed());
  //   });
  //
  //
  // }

  // Future<void>getRecipeComponents()async{
  //
  //   emit(GetRecipesComponentsLoading()); final respone = await DioHelper.getRecipesComponents( endPoint: EndPoint.RecipesDetails, path: 'receta-de-albondigas-de-carne-molida-45979.html').then((value) { var json = value.data;
  //
  //
  //   json.forEach((element) {
  //     RecipesComponent recipes = RecipesComponent.fromJson(element);
  //
  //     recipesComponents = RecipesComponent.fromJson(recipes.toJson());
  //
  //   });
  //   emit(GetRecipesComponentsSucceeded());
  //
  //   }).catchError((error){
  //     print(error.toString());
  //     print('here');
  //     emit(GetRecipesComponentsFailed());}
  //
  //   );}

