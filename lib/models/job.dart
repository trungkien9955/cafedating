class Job {
  String id;
  String name;
  Job({required this.id, required this.name});
  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(id: map['_id'], name: map['name']);
  }
}
