import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/search/notifier/search_filter_notifier.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:cafedating/services/time_translator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchScreenController {
  BuildContext context;
  WidgetRef ref;
  SearchScreenController({required this.context, required this.ref});

  Future<List<UserSearchItem>> fetchUsers() async {
    print('fetch users');
    List<UserSearchItem> userList = [];
    SearchFilter searchFilter = ref.watch(searchFilterNotifierProvider);
    String api = '${AppConstants.serverAddress}/users/search-users';
    Response response =
        await AppDio().post(api, data: {'searchFilter': searchFilter.toMap()});
    if (response.statusCode == 200) {
      for (var item in response.data['data']) {
        Map<String, dynamic> data = {
          'id': item['_id'],
          'name': item['name'],
          'photoUrl': item['photoUrl'],
          'city': item['city'] != null ? item['city']['name'] : '',
          'hometown': item['hometown'] != null ? item['hometown']['name'] : '',
          'joinedAt': item['createdAt'] != null
              ? DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(item['createdAt']))
              : '',
          'lastSeen': item['lastSeen'] != null
              ? TimeTranslator()
                  .translate(timeago.format(DateTime.parse(item['lastSeen'])))
              : '',
          'distance': item['distance']
        };
        UserSearchItem userSearchItem = UserSearchItem.fromMap(data);
        userList.add(userSearchItem);
      }
    }
    print(userList);
    return userList;
  }
}
