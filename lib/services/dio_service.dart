import 'dart:developer';
import 'package:dio/dio.dart';

class DioSevice {
  Dio dio = Dio();
  Future<dynamic> getMethod(String url) async {

    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }
}
