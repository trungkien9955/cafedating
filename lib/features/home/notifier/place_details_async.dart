import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/google_places_notifier.dart';
import 'package:cafedating/features/home/notifier/google_places_search_key_notifier.dart';
import 'package:cafedating/features/home/notifier/place_details_notifier.dart';
import 'package:cafedating/features/home/notifier/place_id_notifier.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/global.dart';
import 'package:cafedating/models/google_places_response_item.dart';
import 'package:cafedating/models/place_details.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_details_async.g.dart';

@riverpod
Future<PlaceDetails> placeDetailsAsync(PlaceDetailsAsyncRef ref) async {
  print('place details async');
  String placeId = ref.read(placeIdNotifierProvider);
  PlaceDetails placeDetails = PlaceDetails(
      formatted_address: '',
      geometry: {},
      name: '',
      photos: [],
      place_id: '',
      types: []);

  if (placeId != '') {
    String api =
        'https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Cformatted_address%2Cgeometry%2Cphotos%2Crating%2Cuser_ratings_total%2Ctypes%2Cplace_id&place_id=${placeId}&key=${AppConstants.googleMapApiKey}';
    String placeDetailsStorage =
        Global.storageService.getString(AppConstants.placeDetails);
    if (placeDetailsStorage == '') {
      print('place details not available');
      Response response = await AppDio().get(api);
      if (response.data['status'] == 'OK') {
        if (response.data['result'] != null) {
          Global.storageService.setString(
              AppConstants.placeDetails, jsonEncode(response.data['result']));
          placeDetails = PlaceDetails.fromMap(response.data['result']);
        }
      }
    } else {
      print('place details available');
      var placeDetails = Global.storageService.getPlaceDetails();
      placeDetails = PlaceDetails.fromMap(placeDetails);
    }
  }
  return placeDetails;
}
