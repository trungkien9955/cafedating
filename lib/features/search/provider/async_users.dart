import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/search/notifier/search_filter_notifier.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'async_users.g.dart';

@riverpod
Future<List<UserSearchItem>> asyncUsers(AsyncUsersRef ref) async {
  List<UserSearchItem> userList = [];
  SearchFilter searchFilter = ref.watch(searchFilterNotifierProvider);
  String api = '${AppConstants.serverAddress}/users/search-users';
  Response response =
      await AppDio().post(api, data: {'searchFilter': searchFilter.toMap()});
  if (response.statusCode == 200) {
    response.data['data'].map((item) {
      Map<String, dynamic> data = {
        'id': item['_id'],
        'name': item['name'],
        'photoUrl': item['photoUrl'],
        'city': item['cityId']['name'],
        'hometown': item['hometownId']['name'],
        // 'joinedAt': item['createdAt'] != null
        //     ? DateTime.parse(item['createdAt']).toString()
        //     : '',
        'joinedAt': '23-11-2024',
        'lastSeen':
            item['lastSeen'] != null ? timeago.format(item['lastSeen']) : '',
        'distance': item['distance']
      };
      UserSearchItem userSearchItem = UserSearchItem.fromMap(data);
      userList.add(userSearchItem);
    });
  }
  return userList;
}
