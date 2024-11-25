import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_profile_interests.g.dart';

@riverpod
Future<List<Interest>> asyncProfileInterests(
    AsyncProfileInterestsRef ref) async {
  String userId =
      Global.storageService.getString(AppConstants.userId).toString();
  String api = '${AppConstants.serverAddress}/users/user-interests';
  print(api);
  Response response =
      await AppDio().post(api, queryParameters: {"userId": userId});
  // List<Interest> selectedInterests = List<Interest>.from(
  //     response.data['data'].map((item) => Interest.fromMap(item)));
  // List<String> selectedInterestIds = [];
  // response.data['data'].map((item) => selectedInterestIds.add(item.id));

  List<Interest> interests = List<Interest>.from(
      response.data['data'].map((item) => Interest.fromMap(item)));
  print('async profile interest $interests');
  return interests;
}
