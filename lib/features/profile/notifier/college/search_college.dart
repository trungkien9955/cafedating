import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/profile/notifier/college/college_search_key_notifier.dart';
import 'package:cafedating/models/college.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_college.g.dart';

@riverpod
Future<List<College>> searchCollege(SearchCollegeRef ref) async {
  String searchKey = ref.watch(collegeSearchKeyNotifierProvider);
  if (searchKey == '') {
    return [];
  }
  if (searchKey != '') {
    String api =
        '${AppConstants.serverAddress}/users/search-colleges?searchKey=$searchKey';
    print(api);
    Response response = await AppDio().get(api);
    List<College> colleges = List<College>.from(
        response.data['data'].map((item) => College.fromMap(item)));
    return colleges;
  }
  return [];
}
