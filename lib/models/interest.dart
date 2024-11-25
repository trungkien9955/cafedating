class Interest {
  String id;
  String name;
  String type;
  Interest({required this.id, required this.name, required this.type});
  factory Interest.fromMap(Map<String, dynamic> map) {
    return Interest(id: map['_id'], name: map['name'], type: map['type']);
  }
}
