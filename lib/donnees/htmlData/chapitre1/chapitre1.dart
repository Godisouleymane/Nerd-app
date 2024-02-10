import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Lesson {
  final String title;
  final String content;

  Lesson(this.title, this.content);
}

class CourseScreen extends StatelessWidget {
  final List<Lesson> lessons;

  CourseScreen(this.lessons);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours d\'introduction à HTML'),
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lessons[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonScreen(lessons[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LessonScreen extends StatelessWidget {
  final Lesson lesson;

  LessonScreen(this.lesson);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              lesson.content,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseScreen(),
                  ),
                );
              },
              child: Text('Commencer l\'exercice'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice interactif'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Validation de l\'exercice'),
                  content: Text(
                      'Félicitations ! Vous avez réussi l\'exercice interactif.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Valider l\'exercice'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction à HTML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CourseScreen(
        [
          Lesson(
            'Comprendre les bases du HTML',
            'Le HTML (HyperText Markup Language) est le langage de balisage standard pour créer des pages Web. '
                'Il définit la structure de la page en utilisant des balises et des éléments.',
          ),
          Lesson(
            'Structure d\'une page HTML',
            'Une page HTML est généralement composée de plusieurs sections, telles que le doctype, la balise html, '
                'le head et le body.',
          ),
          Lesson(
            'Les éléments et balises HTML les plus courants',
            'Les éléments HTML sont les composants de base utilisés pour construire une page Web. Les balises HTML '
                'sont utilisées pour marquer et structurer ces éléments.',
          ),
          Lesson(
            'Syntaxe de base HTML',
            'La syntaxe de base HTML implique l\'utilisation de balises et d\'attributs pour décrire la structure '
                'et le contenu d\'une page Web.',
          ),
        ],
      ),
    );
  }
}
