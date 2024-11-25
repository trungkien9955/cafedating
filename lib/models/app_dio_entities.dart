import 'dart:convert';

import 'package:flutter/widgets.dart';

class AppDioResponseEntity {
  int? code;
  String? msg;
  dynamic data;
  AppDioResponseEntity({
    this.code,
    this.msg,
    required this.data,
  });

  AppDioResponseEntity copyWith({
    ValueGetter<int?>? code,
    ValueGetter<String?>? msg,
    dynamic? data,
  }) {
    return AppDioResponseEntity(
      code: code != null ? code() : this.code,
      msg: msg != null ? msg() : this.msg,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'msg': msg,
      'data': data,
    };
  }

  factory AppDioResponseEntity.fromMap(Map<String, dynamic> map) {
    return AppDioResponseEntity(
      code: map['code']?.toInt(),
      msg: map['msg'],
      data: map['data'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppDioResponseEntity.fromJson(String source) =>
      AppDioResponseEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppDioResponseEntity(code: $code, msg: $msg, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppDioResponseEntity &&
        other.code == code &&
        other.msg == msg &&
        other.data == data;
  }

  @override
  int get hashCode => code.hashCode ^ msg.hashCode ^ data.hashCode;
}
