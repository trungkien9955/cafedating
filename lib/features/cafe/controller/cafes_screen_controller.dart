import 'dart:convert';
import 'dart:math';

import 'package:cafedating/core/common/widgets/app_dialog.dart';
import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/cafe_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class CafesScreenController {
  BuildContext context;
  WidgetRef ref;
  CafesScreenController({required this.context, required this.ref});
  Future<List<CafeResponseItem>> fetchCafes() async {
    print('fetchCafes');
    List<CafeResponseItem> cafeList = [];
    Position position = ref.watch(positionNotifierProvider);
    String api =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude}%2C${position.longitude}&radius=1500&type=cafe&language=vi&key=${AppConstants.googleMapApiKey}';
    print(api);
    String cafeListStorage =
        Global.storageService.getString(AppConstants.cafeList);
    // print('fetch cafes $cafeListStorage');
    if (cafeListStorage == '') {
      try {
        if (context.mounted) {
          AppDialog.showLoadingDialog(context, text: 'Đang tải dữ liệu ...');
        }
        print('cafe list not available');
        await Future.delayed(const Duration(seconds: 1));
        Response response = await AppDio().get(api);
        if (response.statusCode == 200) {
          if (response.data['status'] != 'ZERO_RESULTS') {
            Global.storageService.setString(
                AppConstants.cafeList, jsonEncode(response.data['results']));
            // print(response.data['results']);

            List<CafeResponseItem> cafeListData = List<CafeResponseItem>.from(
                response.data['results']
                    .map((item) => CafeResponseItem.fromMap(item)));
            List<Map<String, dynamic>> dbCafeList =
                List<Map<String, dynamic>>.from(
                    cafeListData.map((item) => item.toMap()));
            const addCafeApi = '${AppConstants.serverAddress}/cafe/add-cafes';
            await AppDio().post(addCafeApi, data: {'cafes': dbCafeList});
            cafeListData.map((item) {
              double distance = calcDistance(
                  userLat: position.latitude,
                  userLng: position.longitude,
                  targetLat: item.geometry['location']['lat'],
                  targetLng: item.geometry['location']['lng']);
              item.distance = distance;
              cafeList.add(item);
            });
          } else {
            print(response.data['status']);
            cafeList = [];
          }
        }
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
      } on DioException catch (error) {
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text:
                  'Không thể tải dữ liệu. Lỗi server: ${error.response?.statusCode}',
              onClose: () {});
        }
      } catch (error) {
        if (context.mounted) {
          AppDialog.hideLoadingDialog(context);
        }
        if (context.mounted) {
          AppDialog.showSimpleDialog(context,
              text: 'Không thể tải dữ liệu. Lỗi ứng dụng.', onClose: () {});
        }
        print(error);
      }
    } else {
      print('cafe list available');

      List cafeListStorage = Global.storageService.getCafeList();
      // print(cafeListStorage);

      List<CafeResponseItem> cafeListData = List<CafeResponseItem>.from(
          cafeListStorage.map((item) => CafeResponseItem.fromMap(item)));
      // print(cafeListData);
      List<Map<String, dynamic>> dbCafeList = List<Map<String, dynamic>>.from(
          cafeListData.map((item) => item.toMap()));
      print('fetch cafes $cafeList ');
      const addCafeApi = '${AppConstants.serverAddress}/cafe/add-cafes';
      await AppDio().post(addCafeApi, data: {'cafes': dbCafeList});
      cafeListData.forEach((item) {
        double distance = calcDistance(
            userLat: position.latitude,
            userLng: position.longitude,
            targetLat: item.geometry['location']['lat'],
            targetLng: item.geometry['location']['lng']);
        item.distance = distance;
        cafeList.add(item);
      });
      // cafeListData.map((item) {
      //   print('item');
      //   double distance = calcDistance(
      //       userLat: position.latitude,
      //       userLng: position.longitude,
      //       targetLat: item.geometry['location']['lat'],
      //       targetLng: item.geometry['location']['lng']);
      //   print(distance);
      //   item.distance = distance;
      //   cafeList.add(item);
      // });
    }
    return cafeList;
  }

  double calcDistance(
      {required userLat,
      required userLng,
      required targetLat,
      required targetLng}) {
    double toRoad(double val) {
      return val * pi / 180;
    }

    int r = 6371;
    double dLat = toRoad(targetLat - userLat);
    double dLng = toRoad(targetLng - userLng);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLng / 2) *
            sin(dLng / 2) *
            cos(toRoad(userLat)) *
            cos(toRoad(targetLat));
    return r * (2 * atan2(sqrt(a), sqrt(1 - a)));
  }
}
