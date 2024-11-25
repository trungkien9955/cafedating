import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_interests.g.dart';

@riverpod
Future<List<Interest>> asyncInterests(AsyncInterestsRef ref) async {
  String api = '${AppConstants.serverAddress}/data/interests';
  print(api);
  Response response = await AppDio().get(api);
  List<Interest> interests = List<Interest>.from(
      response.data['data'].map((item) => Interest.fromMap(item)));
  return interests;
}
