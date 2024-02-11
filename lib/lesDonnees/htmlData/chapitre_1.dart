import 'package:flutter/material.dart';

// Classes pour représenter une leçon et un cours
class Lesson {
  final String title;
  final String content;

  Lesson({required this.title, required this.content});
}

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
        content: 'Contenu de la leçon...2',
      ),
      Lesson(
        title: 'hllo3',
        content: 'Contenu de la leçon...3',
      ),
      Lesson(
        title: 'Balises jvjr',
        content: 'Contenu de la leçon...4',
      ),
      // Ajouter d'autres leçons ici
    ],
  ),
  // Ajouter d'autres cours ici
];

// Page pour afficher le détail d'une leçon
class LessonDetailPage extends StatefulWidget {
  final Lesson lesson;

  const LessonDetailPage({Key? key, required this.lesson}) : super(key: key);

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  int _currentLessonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentLesson = widget.lesson;
    return Scaffold(
      appBar: AppBar(
        title: Text(currentLesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(currentLesson.content),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 15.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              // Vérifier s'il y a une leçon suivante dans la liste des leçons
              if (_currentLessonIndex < courses.firstWhere((course) => course.lessons.contains(widget.lesson)).lessons.length - 1) {
                // Incrémenter l'index pour passer à la leçon suivante
                _currentLessonIndex++;
                // Récupérer la leçon suivante
                final nextLesson = courses
                    .firstWhere(
                        (course) => course.lessons.contains(widget.lesson))
                    .lessons[_currentLessonIndex];

                // Naviguer vers la page LessonDetailPage avec la leçon suivante
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonDetailPage(
                      lesson: nextLesson,
                    ),
                  ),
                );
              } else {
                // Afficher un message si l'utilisateur a terminé toutes les leçons
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Vous avez terminé toutes les leçons de ce cours.'),
                  ),
                );
              }
            });
          },
          child: Text('Next Lesson'),
        ),
      ),
    );
  }
}

// Fonction pour récupérer le contenu d'une leçon
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
