import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String title;
  final List<Module> modules;

  Course({required this.id, required this.modules, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'modules': modules.map((module) => module.toMap()).toList(),
    };
  }
}

class Module {
  final String title;
  final List<Chapter> chapters;

  Module({
    required this.title,
    required this.chapters,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'chapters': chapters.map((chapter) => chapter.toMap()).toList(),
    };
  }
}

class Chapter {
  final String title;
  final List<Lesson> lessons;

  Chapter({
    required this.title,
    required this.lessons
  });

   Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lessons': lessons.map((lesson) => lesson.toMap()).toList(),
    };
  }

}
