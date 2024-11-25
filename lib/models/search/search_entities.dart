import 'package:cafedating/models/selected_position.dart';

class UserSearchItem {
  String id;
  String name;
  String photoUrl;
  String city;
  String hometown;
  String joinedAt;
  String lastSeen;
  String distance;
  UserSearchItem(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.city,
      required this.hometown,
      required this.joinedAt,
      required this.lastSeen,
      required this.distance});
  factory UserSearchItem.fromMap(Map<String, dynamic> map) => UserSearchItem(
      id: map['id'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      city: map['city'],
      hometown: map['hometown'],
      joinedAt: map['joinedAt'],
      lastSeen: map['lastSeen'],
      distance: map['distance']);
}

class SearchFilter {
  String gender;
  SelectedPosition position;
  String cityId;
  String hometownId;
  String jobId;

  SearchFilter(
      {required this.gender,
      required this.position,
      required this.cityId,
      required this.hometownId,
      required this.jobId});
  SearchFilter copyWith(
          {String? gender,
          SelectedPosition? position,
          String? cityId,
          String? hometownId,
          String? jobId}) =>
      SearchFilter(
          gender: gender ?? this.gender,
          position: position ?? this.position,
          cityId: cityId ?? this.cityId,
          hometownId: hometownId ?? this.hometownId,
          jobId: jobId ?? this.jobId);
  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'position': position.toMap(),
      'cityId': cityId,
      'hometownId': hometownId,
      'jobId': jobId
    };
  }
}

class City {
  String id;
  String name;
  City({required this.id, required this.name});
  factory City.fromMap(Map<String, dynamic> map) =>
      City(id: map['_id'], name: map['name']);
}

class Hometown {
  String id;
  String name;
  Hometown({required this.id, required this.name});
  factory Hometown.fromMap(Map<String, dynamic> map) =>
      Hometown(id: map['_id'], name: map['name']);
}
