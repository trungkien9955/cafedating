import 'dart:convert';

import 'package:flutter/widgets.dart';

class LoginRequestEntity {
  String? uid;
  String? name;
  // String? description;
  String? email;
  // String? phone;
  // String? photoUrl;
  // int? online;
  LoginRequestEntity({
    this.uid,
    this.name,
    // this.description,
    this.email,
    // this.phone,
    // this.photoUrl,
    // this.online,
  });

  LoginRequestEntity copyWith({
    ValueGetter<String?>? uid,
    ValueGetter<String?>? name,
    ValueGetter<String?>? description,
    ValueGetter<String?>? email,
    ValueGetter<String?>? phone,
    ValueGetter<String?>? photoUrl,
    ValueGetter<int?>? online,
  }) {
    return LoginRequestEntity(
      uid: uid != null ? uid() : this.uid,
      name: name != null ? name() : this.name,
      // description: description != null ? description() : this.description,
      email: email != null ? email() : this.email,
      // phone: phone != null ? phone() : this.phone,
      // photoUrl: photoUrl != null ? photoUrl() : this.photoUrl,
      // online: online != null ? online() : this.online,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      // 'description': description,
      'email': email,
      // 'phone': phone,
      // 'photoUrl': photoUrl,
      // 'online': online,
    };
  }

  factory LoginRequestEntity.fromMap(Map<String, dynamic> map) {
    return LoginRequestEntity(
      uid: map['uid'],
      name: map['name'],
      // description: map['description'],
      email: map['email'],
      // phone: map['phone'],
      // photoUrl: map['photoUrl'],
      // online: map['online']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestEntity.fromJson(String source) =>
      LoginRequestEntity.fromMap(json.decode(source));
}

class LoginResponseEntity {
  int? code;
  String? msg;
  UserProfile? userData;
  LoginResponseEntity({this.code, this.msg, this.userData});
  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      LoginResponseEntity(
          code: json['code'],
          msg: json['msg'],
          userData: UserProfile.fromMap(json['data']));
}

class UserProfile {
  String? uid;
  String? id;
  String? accessToken;
  String? name;
  String? bio;
  String? photoUrl;
  String? gender;
  UserProfile({
    this.uid,
    this.id,
    this.accessToken,
    this.name,
    this.bio,
    this.photoUrl,
    this.gender,
  });

  UserProfile copyWith({
    ValueGetter<String?>? uid,
    ValueGetter<String?>? id,
    ValueGetter<String?>? accessToken,
    ValueGetter<String?>? name,
    ValueGetter<String?>? bio,
    ValueGetter<String?>? photoUrl,
    ValueGetter<String?>? gender,
  }) {
    return UserProfile(
      uid: uid != null ? uid() : this.uid,
      id: id != null ? id() : this.id,
      accessToken: accessToken != null ? accessToken() : this.accessToken,
      name: name != null ? name() : this.name,
      bio: bio != null ? bio() : this.bio,
      photoUrl: photoUrl != null ? photoUrl() : this.photoUrl,
      gender: gender != null ? gender() : this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'accessToken': accessToken,
      'name': name,
      'bio': bio,
      'photoUrl': photoUrl,
      'gender': gender,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'],
      id: map['id'],
      accessToken: map['accessToken'],
      name: map['name'],
      bio: map['bio'],
      photoUrl: map['photoUrl'],
      gender: map['gender'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(jsonDecode(source));

  @override
  String toString() {
    return 'UserProfile(uid: $uid,id: $id, accessToken: $accessToken, name: $name, description: $bio, , photoUrl: $photoUrl, gender:$gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.uid == uid &&
        other.id == id &&
        other.accessToken == accessToken &&
        other.name == name &&
        other.bio == bio &&
        other.photoUrl == photoUrl &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        id.hashCode ^
        accessToken.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        photoUrl.hashCode ^
        gender.hashCode;
  }
}
