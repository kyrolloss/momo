import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo/components/Text.dart';
import 'package:momo/components/color.dart';
import 'package:momo/models/Categories/Categories.dart';

import '../../cubits/app_cubit.dart';
import '../../models/Categories Details/Categories Details.dart';
import '../../models/New Recipes/New Recipes.dart';

class NewRecipesDetails extends StatefulWidget {
  @override
  State<NewRecipesDetails> createState() => _CategoriesState();
}

class _CategoriesState extends State<NewRecipesDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .08,
              ),
              Row(
                children: [
                  BuildText(
                    text: 'New Recipes',
                    color: AppColor.primeColor,
                    size: 23.50,
                    bold: true,
                  ),
                  BuildText(
                    text: '${cubit.newRecipes.length} Recipes Found',
                    color: Colors.grey,
                    size: 20,
                    bold: true,
                  ),
                ],
              ),
              SizedBox(height: height * .001),
              SizedBox(
                height: height * .9,
                width: width * .85,
                child: ListView.builder(
                  itemCount: cubit.newRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          cubit.getRecipeDetails(cubit.newRecipes[index].path);
                        },
                        child: SizedBox(
                          height: height * .2,
                          width: width * .8,
                          child: Stack(
                            children: [
                              Positioned(
                                height: height * .2,
                                width: width * .65,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          AppColor.primeColor.withOpacity(.9),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: SizedBox(
                                          width: width * .3,
                                          height: height * .1,
                                          child: BuildText(
                                            text:
                                                cubit.newRecipes[index].title!,
                                            color: Colors.white,
                                            size: 17.5,
                                            bold: true,
                                            maxLines: 3,
                                          ))),
                                ),
                              ),
                              Positioned(
                                height: height * .2,
                                width: width * .35,
                                left: 0,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 20,
                                      right: 20,
                                      bottom: 30,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(cubit
                                                  .newRecipes[index].image!),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Positioned(
                                right: 15,
                                top: 65,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_forward_ios_sharp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}
