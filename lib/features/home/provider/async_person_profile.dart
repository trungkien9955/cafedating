import 'package:cafedating/core/constants/app_constants.dart';
import 'package:cafedating/models/home/person_profile.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/models/job.dart';
import 'package:cafedating/models/selected_position.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'async_person_profile.g.dart';

@riverpod
Future<PersonProfile> asyncPersonProfile(
    AsyncPersonProfileRef ref, String userId) async {
  PersonProfile personProfile = PersonProfile(
      id: '',
      name: '',
      photoUrl: '',
      jobs: [],
      interests: [],
      college: '',
      city: '',
      hometown: '',
      lastSeen: DateTime.now());
  String api = '${AppConstants.serverAddress}/map/person-profile';
  Response response =
      await AppDio().post(api, queryParameters: {'userId': userId});
  if (response.statusCode == 200) {
    print('async person profile ${response.data['data']}');
    Map<String, dynamic> personProfileData = {
      'id': response.data['data']['_id'],
      'name': response.data['data']['name'],
      'photoUrl': response.data['data']['photoUrl'],
      'job': List<Job>.from(
          response.data['data']['job'].map((item) => Job.fromMap(item))),
      'interests': List<Interest>.from(response.data['data']['interests']
          .map((item) => Interest.fromMap(item))),
      'college': response.data['data']['city'] != null
          ? response.data['data']['college']['name']
          : '',
      'city': response.data['data']['city'] != null
          ? response.data['data']['city']['name']
          : '',
      'hometown': response.data['data']['hometown'] != null
          ? response.data['data']['hometown']['name']
          : '',
      'lastSeen': response.data['data']['lastSeen'] != null
          ? DateTime.parse(response.data['data']['lastSeen'])
          : DateTime.parse(response.data['data']['createdAt'])
    };
    personProfile = PersonProfile.fromMap(personProfileData);
  }
  return personProfile;
}
