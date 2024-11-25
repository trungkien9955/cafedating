import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/profile/notifier/selected_interests_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileRepo {
  static Future<List<String>?> fetchUserInterests() async {
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    String api = '${AppConstants.serverAddress}/users/selected-interests';
    print('fetch user interest api $api');
    Response response =
        await AppDio().post(api, queryParameters: {"userId": userId});
    if (response.statusCode == 200) {
      // List<String> selectedInterestIds = [];
      List<String> selectedInterestIds =
          List<String>.from(response.data['data'].map((item) => item));

      //  List<String> selectedInterestIds = response.data['data'].map((item) => selectedInterestIds.add(item));
      // print(' fetch users interests ${response.data['data']}');
      print(' fetch users interests $selectedInterestIds');
      return selectedInterestIds;
    } else {
      print(response.statusMessage);
    }
    return null;
    // List<Interest> selectedInterests = List<Interest>.from(
    //     response.data['data'].map((item) => Interest.fromMap(item)));
    // List<String> selectedInterestIds = [];
    // response.data['data'].map((item) => selectedInterestIds.add(item.id));
  }
}
