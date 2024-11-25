import 'dart:convert';

class FilterModel {
  int radius;
  FilterModel({
    required this.radius,
  });

  FilterModel copyWith({
    int? radius,
  }) {
    return FilterModel(
      radius: radius ?? this.radius,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radius': radius,
    };
  }

  factory FilterModel.fromMap(Map<String, dynamic> map) {
    return FilterModel(
      radius: map['radius']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterModel.fromJson(String source) =>
      FilterModel.fromMap(json.decode(source));

  @override
  String toString() => 'FilterModel(radius: $radius)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterModel && other.radius == radius;
  }

  @override
  int get hashCode => radius.hashCode;
}
