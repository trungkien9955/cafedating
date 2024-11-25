import 'dart:convert';

import 'package:flutter/foundation.dart';

class GooglePlacesResponseItem {
  String description;
  List<MatchedSubstringsItem> matched_substrings;
  String place_id;
  String reference;
  Map<String, dynamic> structured_formatting;
  List<TermItem> terms;
  List<String> types;
  GooglePlacesResponseItem({
    required this.description,
    required this.matched_substrings,
    required this.place_id,
    required this.reference,
    required this.structured_formatting,
    required this.terms,
    required this.types,
  });

  GooglePlacesResponseItem copyWith({
    String? description,
    List<MatchedSubstringsItem>? matched_substrings,
    String? place_id,
    String? reference,
    Map<String, dynamic>? structured_formatting,
    List<TermItem>? terms,
    List<String>? types,
  }) {
    return GooglePlacesResponseItem(
      description: description ?? this.description,
      matched_substrings: matched_substrings ?? this.matched_substrings,
      place_id: place_id ?? this.place_id,
      reference: reference ?? this.reference,
      structured_formatting:
          structured_formatting ?? this.structured_formatting,
      terms: terms ?? this.terms,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'matched_substrings': matched_substrings.map((x) => x.toMap()).toList(),
      'place_id': place_id,
      'reference': reference,
      'structured_formatting': structured_formatting,
      'terms': terms.map((x) => x.toMap()).toList(),
      'types': types,
    };
  }

  factory GooglePlacesResponseItem.fromMap(Map<String, dynamic> map) {
    return GooglePlacesResponseItem(
      description: map['description'] ?? '',
      matched_substrings: List<MatchedSubstringsItem>.from(
          map['matched_substrings']
              ?.map((x) => MatchedSubstringsItem.fromMap(x))),
      place_id: map['place_id'] ?? '',
      reference: map['reference'] ?? '',
      structured_formatting:
          Map<String, dynamic>.from(map['structured_formatting']),
      terms: List<TermItem>.from(map['terms']?.map((x) => TermItem.fromMap(x))),
      types: List<String>.from(map['types']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GooglePlacesResponseItem.fromJson(String source) =>
      GooglePlacesResponseItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GooglePlacesResponseItem(description: $description, matched_substrings: $matched_substrings, place_id: $place_id, reference: $reference, structured_formatting: $structured_formatting, terms: $terms, types: $types)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GooglePlacesResponseItem &&
        other.description == description &&
        listEquals(other.matched_substrings, matched_substrings) &&
        other.place_id == place_id &&
        other.reference == reference &&
        mapEquals(other.structured_formatting, structured_formatting) &&
        listEquals(other.terms, terms) &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        matched_substrings.hashCode ^
        place_id.hashCode ^
        reference.hashCode ^
        structured_formatting.hashCode ^
        terms.hashCode ^
        types.hashCode;
  }
}

class MatchedSubstringsItem {
  int length;
  int offset;
  MatchedSubstringsItem({
    required this.length,
    required this.offset,
  });

  MatchedSubstringsItem copyWith({
    int? length,
    int? offset,
  }) {
    return MatchedSubstringsItem(
      length: length ?? this.length,
      offset: offset ?? this.offset,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'length': length,
      'offset': offset,
    };
  }

  factory MatchedSubstringsItem.fromMap(Map<String, dynamic> map) {
    return MatchedSubstringsItem(
      length: map['length']?.toInt() ?? 0,
      offset: map['offset']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchedSubstringsItem.fromJson(String source) =>
      MatchedSubstringsItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'MatchedSubstringsItem(length: $length, offset: $offset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchedSubstringsItem &&
        other.length == length &&
        other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}

class TermItem {
  int offset;
  String value;
  TermItem({
    required this.offset,
    required this.value,
  });

  TermItem copyWith({
    int? offset,
    String? value,
  }) {
    return TermItem(
      offset: offset ?? this.offset,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'offset': offset,
      'value': value,
    };
  }

  factory TermItem.fromMap(Map<String, dynamic> map) {
    return TermItem(
      offset: map['offset']?.toInt() ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TermItem.fromJson(String source) =>
      TermItem.fromMap(json.decode(source));

  @override
  String toString() => 'TermItem(offset: $offset, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TermItem && other.offset == offset && other.value == value;
  }

  @override
  int get hashCode => offset.hashCode ^ value.hashCode;
}
