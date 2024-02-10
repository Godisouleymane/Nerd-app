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
      // d'autres leçons ici
    ],
  ),
  // Ajouter d'autres cours ici
];
