import 'package:code_crafters/services/coures_model.dart';
import 'package:flutter/material.dart';

class CourseSelectionNotifier with ChangeNotifier {
  Course? _selectedCourse;

  Course? get selectedCourse => _selectedCourse;

  void setSelectedCourse(Course course) {
    _selectedCourse = course;
    notifyListeners();
  }
}
