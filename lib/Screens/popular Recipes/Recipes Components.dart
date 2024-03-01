import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:momo/cubits/app_cubit.dart';

import '../../components/Text.dart';
import '../../components/color.dart';
import '../../components/components.dart';
import '../../models/Recipes components/Recipes components.dart';

class RecipesComponents extends StatelessWidget {
  final RecipeModel? recipe;

  const RecipesComponents({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

        if (state is GetRecipesComponentsSucceeded) {
          navigateTo(
              context,
              RecipesComponents(
                recipe: AppCubit.get(context).recipeModel,
              ));
        }
      },
      builder: (context, state) {

        String stepText = '';

        for (String step in AppCubit.get(context).recipeModel.steps!) {
          stepText += step + '\n';
        }

        String componentText = '';

        for (String step in AppCubit.get(context).recipeModel.ingredients!) {
          componentText += step + '\n';
        }


        var cubit = AppCubit.get(context);
        if(state is GetRecipesComponentsLoading){
          return const Center(
            child: SpinKitCubeGrid(
              size: 100,
              color: Colors.deepOrange,

            ),
          );




        }
        else{
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: height * .3,
                            decoration: BoxDecoration(
                                color: AppColor.primeColor,
                                image:  DecorationImage(
                                    image: NetworkImage(
                                        recipe!.imageUrl!
                                    ), fit: BoxFit.fitWidth)),
                          ),
                          Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new_sharp,
                                      color: Colors.black)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const  EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: height * .01,
                        ),
                        SizedBox(
                          height: height*.0325,
                          width: width*.9,
                          child: BuildText(
                            text: recipe!.title!,
                            color: Colors.black,
                            size: 20,
                            bold: true,
                            maxLines: 3,
                          ),
                        ),

                        Column(

                          children: [
                            SizedBox(
                              height: height * .08,
                              width: width * .5,


                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(

                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.access_time,
                                        color: AppColor.primeColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          BuildText(
                                            text: 'Cooking Time',
                                            color: Colors.grey,
                                          ),
                                          BuildText(
                                            text: recipe!.duration!,
                                            color: AppColor.primeColor,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: height * .12,
                              width: width * .5,

                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.person_4,
                                        color: AppColor.primeColor,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          BuildText(
                                            text: 'Portions',
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            height: height*.05,
                                            width: width*.2,
                                            child: BuildText(
                                              text: recipe!.servings!,
                                              color: AppColor.primeColor,
                                              maxLines: 2,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.dinner_dining_sharp,
                              color: AppColor.primeColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: width * .025,
                            ),
                            BuildText(
                              text: 'ingredients',
                              color: Colors.black,
                              size: 35,
                              bold: true,
                            ),
                          ],
                        ),
                        BuildText(
                          text:
                          componentText,
                          maxLines: 25,
                          size: 15,
                          bold: true,
                          color: Colors.black54,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.dining_sharp,
                              color: AppColor.primeColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: width * .025,
                            ),
                            BuildText(
                              text: 'Preparation steps:',
                              color: Colors.black,
                              size: 35,
                              bold: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .025,
                        ),
                        BuildText(
                          text:
                          stepText,
                          maxLines: 25,
                          size: 15,
                          bold: true,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

      },
    );
  }
}
