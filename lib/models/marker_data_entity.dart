import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerDataEntity {
  String markerId;
  double lat;
  double lng;
  String title;
  String snippet;
  BitmapDescriptor icon;
  MarkerDataEntity({
    required this.markerId,
    required this.lat,
    required this.lng,
    required this.title,
    required this.snippet,
    required this.icon,
  });

  MarkerDataEntity copyWith({
    String? markerId,
    double? lat,
    double? long,
    String? title,
    String? snippet,
    BitmapDescriptor? icon,
  }) {
    return MarkerDataEntity(
      markerId: markerId ?? this.markerId,
      lat: lat ?? this.lat,
      lng: long ?? this.lng,
      title: title ?? this.title,
      snippet: snippet ?? this.snippet,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() {
    return 'MarkerDataEntity(markerId: $markerId, lat: $lat, long: $lng, title: $title, snippet: $snippet, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarkerDataEntity &&
        other.markerId == markerId &&
        other.lat == lat &&
        other.lng == lng &&
        other.title == title &&
        other.snippet == snippet &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return markerId.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        title.hashCode ^
        snippet.hashCode ^
        icon.hashCode;
  }
}
