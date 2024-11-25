import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_photo_url.g.dart';

@riverpod
Future<String> asyncPhotoUrl(AsyncPhotoUrlRef ref) async {
  String userId =
      Global.storageService.getString(AppConstants.userId).toString();
  String api = '${AppConstants.serverAddress}/users/photo-url';
  Response response =
      await AppDio().post(api, queryParameters: {"userId": userId});
  return response.data['data'];
}
