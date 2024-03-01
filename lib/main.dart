import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo/helper/dio/Dio%20Helper.dart';
import 'Screens/home Layout.dart';
import 'cubits/app_cubit.dart';

void main() async {
  await DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getPopularRecipe()
        ..getNewRecipe()
        ..getCategories()
        ..getCategoryDetails(),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeLayout()),
    );
  }
}
