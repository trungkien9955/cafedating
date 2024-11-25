import 'dart:convert';

class MarkerProfile {
  String name;
  String photoUrl;
  int age;
  MarkerProfile({
    required this.name,
    required this.photoUrl,
    required this.age,
  });

  MarkerProfile copyWith({
    String? name,
    String? photoUrl,
    int? age,
  }) {
    return MarkerProfile(
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      age: age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'age': age,
    };
  }

  factory MarkerProfile.fromMap(Map<String, dynamic> map) {
    return MarkerProfile(
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      age: map['age']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MarkerProfile.fromJson(String source) =>
      MarkerProfile.fromMap(json.decode(source));

  @override
  String toString() =>
      'MarkerProfile(name: $name, photoUrl: $photoUrl, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarkerProfile &&
        other.name == name &&
        other.photoUrl == photoUrl &&
        other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ photoUrl.hashCode ^ age.hashCode;
}
