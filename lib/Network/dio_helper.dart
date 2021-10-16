import 'package:corona/constant.dart';
import 'package:dio/dio.dart';

class DioHelper {

  static Dio? dio ;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: coronaBaseURL,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    var response =await dio!.get(
      url,
      queryParameters: query,
    );
    print(response.statusCode);
    print(response.data.toString());
    return response;

  }
}