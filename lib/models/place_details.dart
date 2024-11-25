import 'dart:convert';

import 'package:flutter/foundation.dart';

class PlaceDetailsResponseEntity {
  List html_attributions;
  Map<String, dynamic> result;
  String status;
  PlaceDetailsResponseEntity(
      {required this.html_attributions,
      required this.result,
      required this.status});
  factory PlaceDetailsResponseEntity.fromMap(Map<String, dynamic> map) {
    return PlaceDetailsResponseEntity(
        html_attributions: map['html_attributions'],
        result: map['result'],
        status: map['status']);
  }
}

class PlaceDetails {
  String formatted_address;
  Map<String, dynamic> geometry;
  String name;
  List photos;
  String place_id;
  int? rating;
  List types;
  int? user_ratings_total;
  PlaceDetails({
    required this.formatted_address,
    required this.geometry,
    required this.name,
    required this.photos,
    required this.place_id,
    this.rating,
    required this.types,
    this.user_ratings_total,
  });
  factory PlaceDetails.fromMap(Map<String, dynamic> map) {
    return PlaceDetails(
      formatted_address: map['formatted_address'],
      geometry: map['geometry'],
      name: map['name'],
      photos: map['photos'],
      place_id: map['place_id'],
      types: map['types'],
    );
  }
}
