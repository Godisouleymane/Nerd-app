import 'package:cloud_firestore/cloud_firestore.dart';

// Fonction pour récupérer les données du cours HTML à partir de Firestore
Future<Course?> getHtmlCourseFromFirestore() async {
  try {
    DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc('html')
        .get();

    if (courseSnapshot.exists) {
      Map<String, dynamic> courseData =
          courseSnapshot.data() as Map<String, dynamic>;
      Course htmlCourse = Course.fromMap(courseData);
      return htmlCourse;
    } else {
      print('Le cours HTML n\'a pas été trouvé dans Firestore');
      return null;
    }
  } catch (error) {
    print(
        'Erreur lors de la récupération du cours HTML depuis Firestore: $error');
    return null;
  }
}

class Course {
  final String id;
  final String title;
  final List<Module> modules;

  Course({required this.id, required this.title, required this.modules});

  factory Course.fromMap(Map<String, dynamic> map) {
    List<dynamic> modulesData = map['modules'];
    List<Module> modules =
        modulesData.map((moduleData) => Module.fromMap(moduleData)).toList();
    return Course(
      id: map['id'],
      title: map['title'],
      modules: modules,
    );
  }
}

class Module {
  final String title;
  final List<Lesson> lessons;

  Module({required this.title, required this.lessons,});

  factory Module.fromMap(Map<String, dynamic> map) {
    List<dynamic> lessonsData = map['lessons'];
    List<Lesson> lessons = lessonsData
        .map((lessonsData) => Lesson.fromMap(lessonsData))
        .toList();
    return Module(
      title: map['title'],
      lessons: lessons,
    );
  }
}

class Lesson {
  final String title;
  final String content;

  Lesson({required this.title, required this.content});

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      title: map['title'],
      content: map['content'],
    );
  }
}
