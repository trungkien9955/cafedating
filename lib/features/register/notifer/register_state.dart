import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class RegisterState {
  String email;
  String password;
  String rePassword;
  String name;
  String gender;
  String cityId;
  // final String familyName;
  // final String givenName;
  // final String? bio;
  // final String? photoUrl;
  // final List<dynamic>? interests;
  // final String? profileColor;
  RegisterState(
      {required this.email,
      required this.password,
      required this.rePassword,
      required this.name,
      required this.gender,
      required this.cityId
      // required this.familyName,
      // required this.givenName,
      // this.bio,
      // this.photoUrl,
      // this.interests,
      // this.profileColor,
      });

  RegisterState copyWith(
      {String? email,
      String? password,
      String? rePassword,
      String? name,
      String? gender,
      String? cityId
      // String? familyName,
      // String? givenName,
      // ValueGetter<String?>? bio,
      // ValueGetter<String?>? photoUrl,
      // ValueGetter<List<dynamic>?>? interests,
      // ValueGetter<String?>? profileColor,
      }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      cityId: cityId ?? this.cityId,
      // familyName: familyName ?? this.familyName,
      // givenName: givenName ?? this.givenName,
      // bio: bio != null ? bio() : this.bio,
      // photoUrl: photoUrl != null ? photoUrl() : this.photoUrl,
      // interests: interests != null ? interests() : this.interests,
      // profileColor: profileColor != null ? profileColor() : this.profileColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'rePassword': rePassword,
      'name': name,
      'gender': gender,
      'cityId': cityId
      // 'familyName': familyName,
      // 'givenName': givenName,
      // 'bio': bio,
      // 'photoUrl': photoUrl,
      // 'interests': interests,
      // 'profileColor': profileColor,
    };
  }

  factory RegisterState.fromMap(Map<String, dynamic> map) {
    return RegisterState(
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        rePassword: map['rePassword'] ?? '',
        name: map['name'],
        gender: map['gender'] ?? '',
        cityId: map['cityId'] ?? ''
        // familyName: map['familyName'] ?? '',
        // givenName: map['givenName'] ?? '',
        // bio: map['bio'],
        // photoUrl: map['photoUrl'],
        // interests: List<dynamic>.from(map['interests']),
        // profileColor: map['profileColor'],
        );
  }

  String toJson() => json.encode(toMap());

  factory RegisterState.fromJson(String source) =>
      RegisterState.fromMap(json.decode(source));
}
