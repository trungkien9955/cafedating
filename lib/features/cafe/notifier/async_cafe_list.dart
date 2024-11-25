import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/cafe_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_cafe_list.g.dart';

@riverpod
class AsyncCafeList extends _$AsyncCafeList {
  @override
  FutureOr<List<Cafe>> build() async {
    return fetchCafes();
  }

  Future<List<Cafe>> fetchCafes() async {
    List<Cafe> cafeList = [];
    String userId =
        Global.storageService.getString(AppConstants.userId).toString();
    Position position = ref.read(positionNotifierProvider);
    String api = '${AppConstants.serverAddress}/cafe/fetch-cafes';
    await Future.delayed(const Duration(seconds: 1));
    Response response = await AppDio().post(api, data: {'position': position});
    if (response.statusCode == 200) {
      // print(response.data['data'][0]);
      cafeList = List<Cafe>.from(
          response.data['data'].map((item) => Cafe.fromMap(item)));
    }
    return cafeList;
  }

  Future<void> toggleBookmark(String placeId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      String userId =
          Global.storageService.getString(AppConstants.userId).toString();
      String api = '${AppConstants.serverAddress}/cafe/toggle-bookmark';
      await AppDio().post(api,
          data: {'placeId': placeId}, queryParameters: {'userId': userId});
      return fetchCafes();
    });
  }
}
