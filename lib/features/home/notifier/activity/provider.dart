import 'dart:convert';
import 'package:cafedating/features/home/notifier/position_notifier.dart';
import 'package:cafedating/models/activity.dart';
import 'package:cafedating/models/app_dio_entities.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
part 'provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<Activity> activity(ActivityRef ref) async {
  final Position position = ref.watch(positionNotifierProvider);
  print(position);
  // Using package:http, we fetch a random activity from the Bored API.
  final response =
      // await http.get(Uri.https('http://192.168.1.3:3001', '/users/activity'));
      await AppDio().get('/users/activities');
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  // final json = jsonDecode(response);
  // Finally, we convert the Map into an Activity instance.
  return Activity.fromMap(response);
  // return response;
}
