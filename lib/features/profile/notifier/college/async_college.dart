import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/college.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_college.g.dart';

@riverpod
Future<College> asyncCollege(AsyncCollegeRef ref) async {
  String userId = Global.storageService.getString(AppConstants.userId);
  String api = '${AppConstants.serverAddress}/users/college';
  Response response =
      await AppDio().post(api, queryParameters: {"userId": userId});
  College college = College.fromMap(response.data['data']);
  return college;
}
