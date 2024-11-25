class College {
  String id;
  String name;
  College({required this.id, required this.name});
  factory College.fromMap(Map<String, dynamic> map) {
    return College(id: map['id'], name: map['name']);
  }
}
