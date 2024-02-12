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

  Chapter({required this.title, required this.lessons});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'lessons': lessons.map((lesson) => lesson.toMap()).toList(),
    };
  }
}

class Lesson {
  final String title;
  final String content;

  Lesson({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}

void addCourseToFireStore() {
  // creer un object Course pour representer le cours html avec des modules, des chapitres, des lecons

  Course htmlCourse = Course(
    id: 'html',
    title: 'Cours HTML',
    // les modules de ce cours
    modules: [
      Module(
        title: "Introduction à HTML",
        // les chapitres de ce cours;
        chapters: [
          Chapter(
            title: 'Chapitre 1: Les bases du HTML', 
            lessons:[
              Lesson(
                title: 'Leçon 1: Introduction au HTML',
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Structure d\'une page HTML',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            )
            // Je vais ajouter  d'autres chapitre ici in shaa Allah
        ],
      )
      // Je vais ajouter d'autre modules ici in shaa Allah
    ],
  );
}
