import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/storage_const.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    try {
      var response = await dio.get(
        url,
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );
      log(response.toString());
      return response;
    } on DioError catch (err) {
      log(err.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      var token = GetStorage().read(StorageKey.token);
      if (token != null) {
        dio.options.headers['authorization'] = '$token';
      }

      var response = await dio.post(
        url,
        data: dio_service.FormData.fromMap(map),
        options: Options(responseType: ResponseType.json, method: 'POST'),
      );
      log(response.headers.toString());
      log(response.data.toString());
      log(response.statusCode.toString());
      return response;
    } on DioError catch (err) {
      log(err.toString());
      return err.response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
