import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Person {
  Map<String, dynamic>? personInfo;
  List<String>? interests;
  Person({
    this.personInfo,
    this.interests,
  });

  Person copyWith({
    ValueGetter<Map<String, dynamic>?>? personInfo,
    ValueGetter<List<String>?>? interests,
  }) {
    return Person(
      personInfo: personInfo != null ? personInfo() : this.personInfo,
      interests: interests != null ? interests() : this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'personInfo': personInfo,
      'interests': interests,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      personInfo: Map<String, dynamic>.from(map['personInfo']),
      interests: List<String>.from(map['interests']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() => 'Person(personInfo: $personInfo, interests: $interests)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        mapEquals(other.personInfo, personInfo) &&
        listEquals(other.interests, interests);
  }

  @override
  int get hashCode => personInfo.hashCode ^ interests.hashCode;
}
