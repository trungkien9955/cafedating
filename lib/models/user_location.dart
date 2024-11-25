import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UserLocation {
  String location;
  String address;
  UserLocation({
    required this.location,
    required this.address,
  });

  UserLocation copyWith({
    String? location,
    String? address,
  }) {
    return UserLocation(
      location: location ?? this.location,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'address': address,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      location: map['location'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source));

  @override
  String toString() => 'UserLocation(location: $location, address: $address)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserLocation &&
        other.location == location &&
        other.address == address;
  }

  @override
  int get hashCode => location.hashCode ^ address.hashCode;
}
