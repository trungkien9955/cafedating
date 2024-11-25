import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/location_response_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/features/home/notifier/user_location_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/location_response.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
part 'location_notifier.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<LocationResultItem> location(LocationRef ref) async {
  print('location notifier');
  LocationResultItem location = LocationResultItem();
  List<LocationResultItem> locations = [];
  Position position = ref.watch(positionNotifierProvider);
  // final List locationResponse = ref.watch(locationResponseNotifierProvider);
  // Using package:http, we fetch a random activity from the Bored API.
  String apiKey = AppConstants.googleMapApiKey;
  String api =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey';
  String locationResponseStorage =
      Global.storageService.getString(AppConstants.locationResponse);
  if (locationResponseStorage == '') {
    print('location response not yet available');
    Response response = await AppDio().get(api);
    if (response.statusCode == 200) {
      if (response.data['results'] != null) {
        Global.storageService.setString(AppConstants.locationResponse,
            jsonEncode(response.data['results']));

        locations = List<LocationResultItem>.from(response.data['results']
            .map((item) => LocationResultItem.fromMap(item)));
        location = locations[0];
      }
    }
  } else {
    var locationData = Global.storageService.getLocationResponse();
    String serverAddress =
        Global.storageService.getString(AppConstants.serverAddress);
    locations = List<LocationResultItem>.from(
        locationData.map((item) => LocationResultItem.fromMap(item)));
    location = locations[0];
  }
  return location;
}
