import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:cafedating/models/marker_profile.dart';

class MapStats {
  List<MarkerProfile> nearbyPersons;
  MapStats({
    required this.nearbyPersons,
  });

  MapStats copyWith({
    List<MarkerProfile>? nearbyPersons,
  }) {
    return MapStats(
      nearbyPersons: nearbyPersons ?? this.nearbyPersons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nearbyPersons': nearbyPersons.map((x) => x.toMap()).toList(),
    };
  }

  factory MapStats.fromMap(Map<String, dynamic> map) {
    return MapStats(
      nearbyPersons: List<MarkerProfile>.from(
          map['nearbyPersons']?.map((x) => MarkerProfile.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MapStats.fromJson(String source) =>
      MapStats.fromMap(json.decode(source));

  @override
  String toString() => 'MapStats(nearbyPersons: $nearbyPersons)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapStats && listEquals(other.nearbyPersons, nearbyPersons);
  }

  @override
  int get hashCode => nearbyPersons.hashCode;
}
