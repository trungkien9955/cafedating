import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppDio {
  late Dio dio;
  static final AppDio _instance = AppDio._internal();
  factory AppDio() {
    if (kDebugMode) {
      print('http requests ready');
    }
    return _instance;
  }
  AppDio._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.serverAddress,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: 'application/json',
        responseType: ResponseType.json);
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (kDebugMode) {
        print('new request ${options.data}');
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      // if (kDebugMode) {
      //   print('new response ${response.data}');
      // }
      return handler.next(response);
    }, onError: (DioException error, handler) {
      if (kDebugMode) {
        print(error.toString());
      }
      handler.reject(error);
      // ErrorEntity eInfo = createErrorEntity(error);
    }));
  }
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();

    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    requestOptions.headers = requestOptions.headers ?? {};
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: requestOptions);
    // print(response.toString());
    return response;
  }

  get(String path) async {
    Response response = await dio.get(path);
    // print(response.data);
    // print(response.data['results'].toString());
    return response;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = '';
  ErrorEntity({required this.code, required this.message});
  String toString() {
    if (message == '') return 'Exception unknow reason';
    return 'Exception code $code, $message';
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: 'Connection timed out');
    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: 'Send timed out');
    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: 'Receive timed out');
    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: 'Bad SSL certificate');
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: 'Bad request');
        case 401:
          return ErrorEntity(code: 400, message: 'Permission denied');
      }
      return ErrorEntity(code: -1, message: 'Bad response');
    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: 'Cancelled by server');
    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: 'Connection error');
    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: 'Unknown error');
  }
}

void onError(ErrorEntity eInfo) {
  switch (eInfo.code) {
    case 401:
      print('Request denied');
      break;
    case 500:
      print('Internal server error');
      break;
    default:
      print('Unknown error');
      break;
  }
}
