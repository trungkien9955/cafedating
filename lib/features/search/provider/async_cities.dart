import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/search/search_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_cities.g.dart';

@riverpod
Future<List<City>> asyncCities(AsyncCitiesRef ref) async {
  print('async cities');
  List<City> cityList = [];
  String api = '${AppConstants.serverAddress}/data/cities';
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
      City city = City.fromMap(item);
      cityList.add(city);
    }
  }
  print('async cities ${cityList.length}');

  return cityList;
}
