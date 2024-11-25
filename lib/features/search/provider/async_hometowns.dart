import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_hometowns.g.dart';

@riverpod
Future<List<Hometown>> asyncHometowns(AsyncHometownsRef ref) async {
  List<Hometown> hometownList = [];
  String api = '${AppConstants.serverAddress}/data/hometowns';
  Response response = await AppDio().get(api);
  if (response.statusCode == 200) {
    // print(response.data['data']);
    // response.data['data'].map((item) {
    //   // print(item);
    //   City city = City.fromMap(item);
    //   print(city);
    //   cityList.add(city);
    // });
    for (var item in response.data['data']) {
      Hometown hometown = Hometown.fromMap(item);
      hometownList.add(hometown);
    }
  }

  return hometownList;
}
