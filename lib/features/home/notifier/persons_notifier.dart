import 'dart:convert';

import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/models/location_response.dart';
import 'package:cafedating/models/persons.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
part 'persons_notifier.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<List<Person>> persons(PersonsRef ref) async {
  String baseUrl = 'http://192.168.100.229:3001';
  var response = await AppDio().get('$baseUrl/users/persons');

  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  // final json = jsonDecode(response);
  // Finally, we convert the Map into an Activity instance.
  // List<LocationResultItem>.from(
  //     response['data'].map((item) => LocationResultItem.fromJson(item)));
  return response['persons'] == null
      ? []
      : List<Person>.from(
          response['persons'].map((item) => Person.fromMap(item)));
  // return response;
}
