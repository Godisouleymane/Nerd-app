import 'package:flutter/material.dart';

// Classe pour représenter une leçon
class Lesson {
  final String title;
  final String content;

  Lesson({required this.title, required this.content});
}

// Classe pour représenter un cours avec des leçons
class Course {
  final String title;
  final List<Lesson> lessons;

  Course({required this.title, required this.lessons});
}

// Liste de cours avec des leçons
final List<Course> courses = [
  Course(
    title: 'Comprendre les bases du HTML',
    lessons: [
      Lesson(
        title: 'Introduction au HTML',
        content: 'Contenu de la leçon...',
      ),
      Lesson(
        title: 'Balises HTML',
        content: 'Contenu de la leçon...',
      ),
      // Ajouter d'autres leçons ici
    ],
  ),
  // Ajouter d'autres cours ici
];

// Page pour afficher le détail d'une leçon
class LessonDetailPage extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onNextLesson;

  const LessonDetailPage(
      {Key? key, required this.lesson, required this.onNextLesson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(lesson.content),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child:  ElevatedButton(
              onPressed: onNextLesson,
              child: Text('Next Lesson'),
            ),
        ),
    );
  }
}

// Fonction pour récupérer le contenu d'un cours
Lesson getCourseContent(String courseTitle) {
  // Parcourir la liste des cours pour trouver le cours correspondant
  for (final course in courses) {
    if (course.title == courseTitle) {
      // Retourner la première leçon du cours
      return course.lessons.first;
    }
  }
  // Retourner une leçon vide si le cours n'est pas trouvé
  return Lesson(title: 'Not Found', content: 'Contenu non trouvé');
}
