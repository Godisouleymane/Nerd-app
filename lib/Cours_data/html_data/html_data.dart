import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String title;
  final List<Modules> modules;

  Course({required this.id, required this.modules, required this.title});
  
}

class Modules {
}
