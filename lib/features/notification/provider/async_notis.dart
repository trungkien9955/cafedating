import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/noti/noti_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:cafedating/services/time_translator.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'async_notis.g.dart';

@riverpod
Future<List<Noti>> asyncNotis(AsyncNotisRef ref) async {
  List<Noti> notiList = [];
  String userId =
      Global.storageService.getString(AppConstants.userId).toString();
  String api = '${AppConstants.serverAddress}/users/notis';
  Response response =
      await AppDio().post(api, queryParameters: {'userId': userId});
  print('async notis $api');
  if (response.statusCode == 200) {
    for (var item in response.data['data']) {
      Map<String, dynamic> notiData = {
        'id': item['_id'],
        'type': item['type'],
        'senderId': item['senderId']['_id'],
        'senderName': item['senderId']['name'],
        'receiverId': item['receiverId'],
        'senderPhotoUrl': item['senderId']['photoUrl'],
        'title': item['title'],
        'body': item['body'],
        'isRead': item['isRead'],
        'time': TimeTranslator()
            .translate(timeago.format(DateTime.parse(item['createdAt'])))
      };
      Noti noti = Noti.fromMap(notiData);
      notiList.add(noti);
    }
  }
  return notiList;
}
