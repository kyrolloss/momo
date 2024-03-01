import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:momo/helper/dio/end%20points/end%20points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: EndPoint.baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ));


  }
  static Future<Response> getRecipes(
      {required String endPoint,
        Map<String, dynamic>? queryParameters}) async {
    try {
      dio.options.headers = EndPoint.header;
      final Response response =
      await dio.get(endPoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      print(e);
      rethrow ;
    }
  }

  static Future<dynamic> getRecipesComponents(
      {required String endPoint,
        required String Path
       }) async {
    try {
      dio.options.headers = EndPoint.header;
      final Response response =
      await dio.get(endPoint, queryParameters: {
        'path' : Path    ,
      });
      return response.data;
    } catch (e) {
      print(e);
      print('error here in dio');

      throw e.toString() ;
    }
  }

  static Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
            headers: {
              'X-RapidAPI-Key': 'c1bd27a3efmsh815c7e0528dda93p18acbfjsnaf13a2af1b36',
              'X-RapidAPI-Host': 'recipe-book2.p.rapidapi.com'
            }
        ),
      );
      return response;
    } catch (error) {
      print('error here');
      throw error.toString();

    }
  }

  static Future<Response> CategoryDetails(
      {required String endPoint,
        Map<int, dynamic>? queryParameters , required int page , required String path }) async {
    try {
      dio.options.headers = EndPoint.header;
      final Response response =
      await dio.get(endPoint, queryParameters: {
        'page': page,
        'path': path


      });
      return response;
    } catch (e) {
      print(e);
      rethrow ;
    }
  }
}
