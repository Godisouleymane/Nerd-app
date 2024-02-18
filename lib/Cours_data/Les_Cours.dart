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
    modules: [
      Module(
        title: "Introduction à HTML",
        chapters: [
          Chapter(title: 'Chapitre 1: Les bases du HTML',
           lessons: [
            Lesson(
              title: 'Leçon 1: Introduction au HTML',
              content:
                  'Présentation du HTML, historique et importance dans le développement web. Vue d\'ensemble de la structure d\'un document HTML.',
            ),
            Lesson(
              title: 'Leçon 2: Les éléments de base',
              content:
                  'Explication des balises, attributs et éléments HTML. Distinction entre balises ouvrantes, fermantes et auto-fermantes.',
            ),
            Lesson(
              title: 'Leçon 3: Structurer une page HTML',
              content:
                  'Utilisation des balises <html>, <head>, <title>, et <body>. Introduction à la hiérarchie des éléments.',
            ),
          ]),
        ],
       
      ),
      Module(
        title: "Structure et Sémantique",
        chapters: [
          Chapter(
              title: 'Chapitre 1: Utilisation des éléments sémantiques HTML5',
              lessons: [
                Lesson(
                  title: 'Leçon 1: Introduction au structure et sémantique',
                  content:
                      'Importance des éléments sémantiques pour l\'accessibilité et le SEO. Vue d\'ensemble et usage de <main>, <aside>, <article>, et <section>.',
                ),
                Lesson(
                  title: 'Leçon 2: Header',
                  content:
                      'Structurer une navigation web avec <nav> et listes. Utilisation des liens internes et externes.',
                ),
                Lesson(
                  title: 'Leçon 3: Comprendre les éléments sémantiques',
                  content:
                      'Approfondissement sur l\'utilisation des éléments sémantiques et leur impact sur le SEO et l\'accessibilité.',
                ),
                Lesson(
                  title: 'Leçon 4: Navigation',
                  content:
                      'Explication détaillée de la balise <nav> et de l\'organisation des liens de navigation dans une page web.',
                ),
              ]),
          Chapter(
              title:
                  "Chapitre 2: Importance de la sémantique dans le référencement et l'accessibilité",
              lessons: [
                Lesson(
                  title: "Leçon 1: SEO et accessibilité",
                  content:
                      'Bonnes pratiques pour améliorer le référencement et l\'accessibilité d\'une page web en utilisant la sémantique HTML.',
                ),
              ]),
        ],
       
      ),
      Module(
        title: "Liens, Images et Médias",
        chapters: [
          Chapter(title: 'Chapitre 1: Création de liens hypertextes', lessons: [
            Lesson(
              title: 'Leçon 1: Approfondissement sur les liens',
              content:
                  'Utilisation avancée des ancres, liens vers des emails et numéros de téléphone. Gestion des attributs target et rel.',
            ),
          ]),
          Chapter(title: "Chapitre 4: Formulaires", lessons: [
            Lesson(
              title: "Leçon 1: Création de formulaires HTML",
              content:
                  'Introduction aux types d\'input HTML5 comme date, range, et color. Utilisation de datalist pour les suggestions.',
            ),
            Lesson(
              title: 'Leçon 2: Validation de formulaire côté client',
              content:
                  'Utilisation des attributs required, pattern, et min/max pour valider les entrées utilisateur.',
            ),
          ]),
        ],
        
      ),
      Module(
        title: "Bonnes Pratiques et Normes",
        chapters: [
          Chapter(
              title: 'Chapitre 1: Les meilleures pratiques pour le codage HTML',
              lessons: [
                Lesson(
                  title:
                      'Leçon 1: Commentaires, indentation et conventions de nommage',
                  content:
                      'L\'importance des commentaires, de l\'indentation propre et des conventions de nommage pour améliorer la lisibilité du code.',
                ),
               
              ]),
          Chapter(
              title: "Chapitre 2: Validation HTML et accessibilité",
              lessons: [
                Lesson(
                  title: "Leçon 1: Utiliser les outils de validation HTML",
                  content:
                      'Présentation des outils de validation W3C et comment les utiliser pour vérifier la conformité de vos pages HTML.',
                ),
                Lesson(
                  title: 'Leçon 2: Principes de base de l\'accessibilité',
                  content:
                      'Introduction à l\'accessibilité web, utilisation des balises ARIA et importance de la navigation au clavier.',
                ),
              ]),
        ],
      
      ),
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

 

