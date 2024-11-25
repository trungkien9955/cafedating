import 'dart:convert';

class Activity {
  String key;
  String activity;
  String type;
  int paticipants;
  double price;
  Activity({
    required this.key,
    required this.activity,
    required this.type,
    required this.paticipants,
    required this.price,
  });

  Activity copyWith({
    String? key,
    String? activity,
    String? type,
    int? paticipants,
    double? price,
  }) {
    return Activity(
      key: key ?? this.key,
      activity: activity ?? this.activity,
      type: type ?? this.type,
      paticipants: paticipants ?? this.paticipants,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'activity': activity,
      'type': type,
      'paticipants': paticipants,
      'price': price,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      key: map['key'] ?? '',
      activity: map['activity'] ?? '',
      type: map['type'] ?? '',
      paticipants: map['paticipants']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Activity(key: $key, activity: $activity, type: $type, paticipants: $paticipants, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity &&
        other.key == key &&
        other.activity == activity &&
        other.type == type &&
        other.paticipants == paticipants &&
        other.price == price;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        activity.hashCode ^
        type.hashCode ^
        paticipants.hashCode ^
        price.hashCode;
  }
}
