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
      ),
      Module(
        title: "Structure et Sémantique",
        // les chapitres de ce cours;
        chapters: [
          Chapter(
            title: 'Chapitre 1: Utilisation des éléments sémantiques HTML5 (header, footer, nav, section, article, etc.)', 
            lessons:[
              Lesson(
                title: 'Leçon 1: Introduction au structure et sémantique',
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 2: Importance de la sémantique dans le référencement et l'accessibilité", 
            lessons:[
              Lesson(
                title: "Leçon 1: Introduction au structure et sémantique",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 3: Importance de la sémantique dans le référencement et l'accessibilité", 
            lessons:[
              Lesson(
                title: "Leçon 1: Introduction au structure et sémantique",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
            // Je vais ajouter  d'autres chapitre ici in shaa Allah
        ],
      ),
      Module(
        title: "Liens, Images et Médias",
        // les chapitres de ce cours;
        chapters: [
          Chapter(
            title: 'Chapitre 1: Création de liens hypertextes', 
            lessons:[
              Lesson(
                title: 'Leçon 1: Introduction au structure et sémantique',
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 2: Intégration d'images dans une page HTML", 
            lessons:[
              Lesson(
                title: "Leçon 1: Introduction au structure et sémantique",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 3: Utilisation de balises pour l'audio et la vidéo", 
            lessons:[
              Lesson(
                title: "Leçon 1: Introduction au structure et sémantique",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 4: Formulaires", 
            lessons:[
              Lesson(
                title: "Leçon 1: Création de formulaires HTML",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
            // Je vais ajouter  d'autres chapitre ici in shaa Allah
        ],
      ),
      Module(
        title: "Bonnes Pratiques et Normes",
        // les chapitres de ce cours;
        chapters: [
          Chapter(
            title: 'Chapitre 1:Les meilleures pratiques pour le codage HTML', 
            lessons:[
              Lesson(
                title: 'Leçon 1: Introduction au structure et sémantique',
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
          Chapter(
            title: "Chapitre 2: Validation HTML et accessibilité", 
            lessons:[
              Lesson(
                title: "Leçon 1: Introduction au structure et sémantique",
                content: 'Contenu de la leçon...',
               ),
              Lesson(
                title: 'Leçon 2: Header',
                content: 'Contenu de la leçon...',
              ),

              // Je vais ajouter d'autre lesson ici in shaa Allah
            ]
            ),
            // Je vais ajouter  d'autres chapitre ici in shaa Allah
        ],
      ),
      // Je vais ajouter d'autre modules ici in shaa Allah
    ],
  );

   // Ajouter le cours HTML à Firestore
  FirebaseFirestore.instance
      .collection('courses')
      .doc(htmlCourse.id)
      .set(htmlCourse.toMap())
      .then((_) {
    print('Le cours HTML a été ajouté avec succès à Firestore');
  }).catchError((error) {
    print('Erreur lors de l\'ajout du cours HTML à Firestore: $error');
  });
}

 

