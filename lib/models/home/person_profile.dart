import 'package:cafedating/models/college.dart';
import 'package:cafedating/models/interest.dart';
import 'package:cafedating/models/job.dart';
import 'package:cafedating/models/selected_position.dart';

class PersonProfile {
  String id;
  String name;
  String photoUrl;
  List<Job> jobs;
  List<Interest> interests;
  String college;
  String city;
  String hometown;
  DateTime lastSeen;

  PersonProfile(
      {required this.id,
      required this.name,
      required this.photoUrl,
      required this.jobs,
      required this.interests,
      required this.college,
      required this.city,
      required this.hometown,
      required this.lastSeen});
  factory PersonProfile.fromMap(Map<String, dynamic> map) {
    return PersonProfile(
      id: map['id'],
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      jobs: map['job'],
      interests: map['interests'],
      college: map['college'],
      city: map['city'],
      hometown: map['hometown'],
      lastSeen: map['lastSeen'],
    );
  }
}
