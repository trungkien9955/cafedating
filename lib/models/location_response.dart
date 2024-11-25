import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LocationResponse {
  List<LocationResultItem>? results;
  LocationResponse({
    this.results,
  });

  LocationResponse copyWith({
    ValueGetter<List<LocationResultItem>?>? results,
  }) {
    return LocationResponse(
      results: results != null ? results() : this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'results': results?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory LocationResponse.fromMap(Map<String, dynamic> map) {
    return LocationResponse(
      results: map['results'] != null
          ? List<LocationResultItem>.from(
              map['results']?.map((x) => LocationResultItem.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResponse.fromJson(String source) =>
      LocationResponse.fromMap(json.decode(source));

  @override
  String toString() => 'LocationResponse(results: $results)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationResponse && listEquals(other.results, results);
  }

  @override
  int get hashCode => results.hashCode;
}

class LocationResultItem {
  List<AddressComponent>? address_components;
  String? formatted_address;
  Map<String, dynamic>? geometry;
  String? place_id;
  Map<String, dynamic>? plus_code;
  List<String>? types;
  LocationResultItem({
    this.address_components,
    this.formatted_address,
    this.geometry,
    this.place_id,
    this.plus_code,
    this.types,
  });

  LocationResultItem copyWith({
    ValueGetter<List<AddressComponent>?>? address_components,
    ValueGetter<String?>? formatted_address,
    ValueGetter<Map<String, dynamic>?>? geometry,
    ValueGetter<String?>? place_id,
    ValueGetter<Map<String, dynamic>?>? plus_code,
    ValueGetter<List<String>?>? types,
  }) {
    return LocationResultItem(
      address_components: address_components != null
          ? address_components()
          : this.address_components,
      formatted_address: formatted_address != null
          ? formatted_address()
          : this.formatted_address,
      geometry: geometry != null ? geometry() : this.geometry,
      place_id: place_id != null ? place_id() : this.place_id,
      plus_code: plus_code != null ? plus_code() : this.plus_code,
      types: types != null ? types() : this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address_components':
          address_components?.map((x) => x?.toMap())?.toList(),
      'formatted_address': formatted_address,
      'geometry': geometry,
      'place_id': place_id,
      'plus_code': plus_code,
      'types': types,
    };
  }

  factory LocationResultItem.fromMap(Map<String, dynamic> map) {
    return LocationResultItem(
      address_components: map['address_components'] != null
          ? List<AddressComponent>.from(map['address_components']
              ?.map((x) => AddressComponent.fromMap(x)))
          : null,
      formatted_address: map['formatted_address'],
      geometry: Map<String, dynamic>.from(map['geometry']),
      place_id: map['place_id'],
      plus_code: map['plus_code'] != null
          ? Map<String, dynamic>.from(map['plus_code'])
          : {},
      types: List<String>.from(map['types']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResultItem.fromJson(String source) =>
      LocationResultItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocationResultItem(address_components: $address_components, formatted_address: $formatted_address, geometry: $geometry, place_id: $place_id, plus_code: $plus_code, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationResultItem &&
        listEquals(other.address_components, address_components) &&
        other.formatted_address == formatted_address &&
        mapEquals(other.geometry, geometry) &&
        other.place_id == place_id &&
        mapEquals(other.plus_code, plus_code) &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode {
    return address_components.hashCode ^
        formatted_address.hashCode ^
        geometry.hashCode ^
        place_id.hashCode ^
        plus_code.hashCode ^
        types.hashCode;
  }
}

class AddressComponent {
  String? long_name;
  String? short_name;
  List<String>? types;
  AddressComponent({
    this.long_name,
    this.short_name,
    this.types,
  });

  AddressComponent copyWith({
    ValueGetter<String?>? long_name,
    ValueGetter<String?>? short_name,
    ValueGetter<List<String>?>? types,
  }) {
    return AddressComponent(
      long_name: long_name != null ? long_name() : this.long_name,
      short_name: short_name != null ? short_name() : this.short_name,
      types: types != null ? types() : this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'long_name': long_name,
      'short_name': short_name,
      'types': types,
    };
  }

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      long_name: map['long_name'],
      short_name: map['short_name'],
      types: List<String>.from(map['types']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressComponent.fromJson(String source) =>
      AddressComponent.fromMap(json.decode(source));

  @override
  String toString() =>
      'AddressComponent(long_name: $long_name, short_name: $short_name, types: $types)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressComponent &&
        other.long_name == long_name &&
        other.short_name == short_name &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode => long_name.hashCode ^ short_name.hashCode ^ types.hashCode;
}
