import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo/components/Text.dart';
import 'package:momo/components/color.dart';
import 'package:momo/models/Categories/Categories.dart';

import '../../cubits/app_cubit.dart';
import '../../models/Categories Details/Categories Details.dart';

class CategoriesDetailes extends StatefulWidget {
  Categoriesdetails category;
  Categories categories ;

  CategoriesDetailes({required this.category , required this.categories });

  @override
  State<CategoriesDetailes> createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesDetailes>
    with SingleTickerProviderStateMixin {


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
                    text: '${cubit.categoryDetails.length} ',
                    color: AppColor.primeColor,
                    size: 23.50,
                    bold: true,
                  ),
                  BuildText(
                    text: '${widget.categories.title} Recipes Found',
                    color: Colors.grey,
                    size: 20,
                    bold: true,
                  ),
                ],
              ),
              SizedBox(
                height: height * .001
              ),
              SizedBox(
                height: height * .9,
                width: width * .85,
                child: ListView.builder(
                  itemCount: cubit.categoryDetails.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          cubit.getRecipeDetails(cubit.categoryDetails[index].path);
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
                                      color: AppColor.primeColor.withOpacity(.9),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Center(child: SizedBox(
                                      width: width*.3,
                                      height: height*.1,
                                      child: BuildText(text: cubit.categoryDetails[index].title! , color: Colors.white,size: 17.5,bold: true,maxLines: 3,))),
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
                                                  .categoryDetails[index]
                                                  .image!),
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
