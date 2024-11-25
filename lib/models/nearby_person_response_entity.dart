import 'dart:convert';

import 'package:flutter/foundation.dart';

class NearbyPersonResponseEntity {
  String id;
  String name;
  NearbyPersonPosition position;
  String photoUrl;
  int age;
  NearbyPersonResponseEntity({
    required this.id,
    required this.name,
    required this.position,
    required this.photoUrl,
    required this.age,
  });
  factory NearbyPersonResponseEntity.fromMap(Map<String, dynamic> map) =>
      NearbyPersonResponseEntity(
          id: map['id'],
          name: map['name'],
          position: NearbyPersonPosition(
              lat: map['position']['lat'], lng: map['position']['long']),
          photoUrl: map['photoUrl'],
          age: map['age']);
}

class NearbyPersonPosition {
  double lat;
  double lng;
  NearbyPersonPosition({required this.lat, required this.lng});
}
