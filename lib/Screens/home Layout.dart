import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:momo/Screens/Categories/Categories.dart';
import 'package:momo/Screens/New%20Recipes/New%20Recipes%20Details.dart';
import 'package:momo/Screens/popular%20Recipes/Popular%20Recipes%20Details.dart';
import 'package:momo/Screens/popular%20Recipes/Recipes%20Components.dart';
import 'package:momo/components/Text.dart';
import 'package:momo/components/color.dart';
import 'package:momo/components/components.dart';

import '../cubits/app_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
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

        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        const spinkit = SpinKitCubeGrid(
          size: 50,
          color: Colors.deepOrange,
        );

        return Scaffold(
          backgroundColor: const Color(0xffF4F4F4),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: height * .15,
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColor.primeColor,
                        borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(20),
                            bottomStart: Radius.circular(20))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.deepOrange,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(right: 15.0, left: 15),
                              child: Icon(Icons.search),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Search',
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,top: 12),
                      child: BuildText(
                        text: 'Categories',
                        bold: true,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.085,
                  // width: width*.9,
                  child: ListView.builder(
                    itemCount: cubit.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return cubit.categories.isEmpty
                          ? spinkit
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.getCategoryDetails(
                                      path: cubit.categories[index].path!,
                                      page: cubit.page);
                                  navigateTo(
                                      context,
                                      CategoriesDetailes(
                                        category: cubit.categoryDetails[index],
                                        categories: cubit.categories[index],
                                      ));
                                  cubit.categoryDetails.clear();
                                },
                                child: Container(
                                  height: height * .005,
                                  width: width * .3,
                                  decoration: BoxDecoration(
                                      color: AppColor.primeColor,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(
                                      child: BuildText(
                                    text: cubit.categories[index].title!,
                                    bold: true,
                                    color: Colors.white,
                                    size: 17.5,
                                    letterSpacing: .75,
                                  )),
                                ),
                              ),
                            );
                    },
                  ),
                ),

                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: BuildText(
                        text: 'New Recipes',
                        bold: true,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextButton(
                          onPressed: () {
                            navigateTo(context, NewRecipesDetails());
                          },
                          child: BuildText(
                            text: 'See All',
                            size: 15,
                            bold: true,
                            color: Colors.red,
                          ),
                        )),
                  ],
                ),

                SizedBox(
                  height: height * 0.01,
                ),
                SizedBox(
                  height: height * .2,
                  width: width * 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          height: height * .55,
                          width: width * .5,
                          child: cubit.newRecipes.isEmpty
                              ? spinkit
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.getRecipeDetails(
                                          cubit.newRecipes[index].path);
                                    },
                                    child: Stack(children: [
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          height: height * .175,
                                          width: width * .4,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    cubit.newRecipes[index]
                                                        .image!,
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          height: height * .07,
                                          width: width * .4,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffE4E4E4),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17.5),
                                                child: BuildText(
                                                  text: cubit
                                                      .newRecipes[index].title!,
                                                  bold: true,
                                                  color: Colors.black,
                                                  size: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * .002,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 17.5),
                                                child: BuildText(
                                                  text: cubit.newRecipes[index]
                                                      .newCategory!,
                                                  bold: true,
                                                  color: Colors.black45,
                                                  size: 17.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ));
                    },
                  ),
                ),

                SizedBox(
                  height: height * .0075,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: BuildText(
                        text: 'Popular Recipes',
                        bold: true,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextButton(
                          onPressed: () {
                            navigateTo(context, const PopularRecipesDetails());
                          },
                          child: BuildText(
                            text: 'See All',
                            size: 15,
                            bold: true,
                            color: Colors.red,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * .9,
                  width: width * .85,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: cubit.popularRecipes.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: spinkit,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  cubit.getRecipeDetails(
                                      cubit.popularRecipes[index].path!);
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
                                              color: AppColor.primeColor
                                                  .withOpacity(.9),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                              child: SizedBox(
                                                  width: width * .3,
                                                  height: height * .1,
                                                  child: BuildText(
                                                    text: cubit
                                                        .popularRecipes[index]
                                                        .title!,
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
                                                          .popularRecipes[index]
                                                          .image!),
                                                      fit: BoxFit.cover),
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
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
                                          child: Icon(
                                              Icons.arrow_forward_ios_sharp),
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

                //
              ],
            ),
          ),
        );
      },
    );
  }
}
