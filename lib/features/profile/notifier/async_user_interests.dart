import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_user_interests.g.dart';

@riverpod
Future<List<String>> asyncUserInterests(AsyncUserInterestsRef ref) async {
  String userId =
      Global.storageService.getString(AppConstants.userId).toString();
  String api = '${AppConstants.serverAddress}/users/selected-interests';
  Response response =
      await AppDio().post(api, queryParameters: {"userId": userId});
  // List<Interest> selectedInterests = List<Interest>.from(
  //     response.data['data'].map((item) => Interest.fromMap(item)));
  // List<String> selectedInterestIds = [];
  // response.data['data'].map((item) => selectedInterestIds.add(item.id));
  List<String> selectedInterestIds = [];
  response.data['data'].map((item) => selectedInterestIds.add(item));
  return selectedInterestIds;
}
