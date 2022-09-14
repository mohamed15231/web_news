import 'package:dio/dio.dart';

class DioApp {
  static Dio? dio;

  static void initialDio() {
    dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future getDio({
  required String path,
  required Map<String, dynamic> query
})async{
  return await dio?.get(
        path,
      queryParameters: query,
    );
  }
}
