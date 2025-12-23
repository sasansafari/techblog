import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/storage_const.dart';

class DioService {
  Dio dio = Dio();

  // ========= ANSI COLORS =========
  static const _blue = '\x1B[34m';
  static const _green = '\x1B[32m';
  static const _red = '\x1B[31m';
  static const _grey = '\x1B[90m';
  static const _reset = '\x1B[0m';

  // ===================== GET =====================
  Future<dynamic> getMethod(String url) async {
    log('$_blue[GET] $url$_reset', name: 'DioService');

    try {
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.json, method: 'GET'),
      );

      log('$_green[GET SUCCESS]$_reset', name: 'DioService');
      log('${_grey}STATUS: ${response.statusCode}$_reset', name: 'DioService');
      log('${_grey}HEADERS: ${response.headers}$_reset', name: 'DioService');
      log('${_grey}DATA: ${response.data}$_reset', name: 'DioService');

      return response;
    } on DioException catch (e) {
      _logDioError(e, method: 'GET', url: url);
      return e.response;
    } catch (e, s) {
      log(
        '$_red[GET UNEXPECTED ERROR] $e$_reset',
        name: 'DioService',
        stackTrace: s,
      );
      return null;
    }
  }

  // ===================== POST =====================
  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    log('$_blue[POST] $url$_reset', name: 'DioService');
    log('${_grey}BODY: $map$_reset', name: 'DioService');

    try {
      dio.options.headers['content-type'] = 'application/json';

      final token = GetStorage().read(StorageKey.token);
      if (token != null) {
        dio.options.headers['authorization'] = token;
        log('${_grey}AUTH TOKEN ATTACHED$_reset', name: 'DioService');
      }

      final response = await dio.post(
        url,
        data: dio_service.FormData.fromMap(map),
        options: Options(responseType: ResponseType.json, method: 'POST'),
      );

      log('$_green[POST SUCCESS]$_reset', name: 'DioService');
      log('${_grey}STATUS: ${response.statusCode}$_reset', name: 'DioService');
      log('${_grey}HEADERS: ${response.headers}$_reset', name: 'DioService');
      log('${_grey}DATA: ${response.data}$_reset', name: 'DioService');

      return response;
    } on DioException catch (e) {
      _logDioError(e, method: 'POST', url: url);
      return e.response;
    } catch (e, s) {
      log(
        '$_red[POST UNEXPECTED ERROR] $e$_reset',
        name: 'DioService',
        stackTrace: s,
      );
      return null;
    }
  }

  // ===================== ERROR LOGGER =====================
  void _logDioError(
    DioException e, {
    required String method,
    required String url,
  }) {
    log('$_red[$method ERROR] $url$_reset', name: 'DioService');
    log('${_red}TYPE: ${e.type}$_reset', name: 'DioService');
    log('${_red}MESSAGE: ${e.message}$_reset', name: 'DioService');

    if (e.response != null) {
      log(
        '${_red}STATUS: ${e.response?.statusCode}$_reset',
        name: 'DioService',
      );
      log('${_red}DATA: ${e.response?.data}$_reset', name: 'DioService');
    } else {
      log('${_red}NO RESPONSE FROM SERVER$_reset', name: 'DioService');
    }
  }
}
