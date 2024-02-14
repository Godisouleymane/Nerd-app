import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours HTML'),
      ),
      body: FutureBuilder<Course?>(
        future: getHtmlCourseFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée trouvée'));
          } else {
            Course course = snapshot.data!;
            return ListView.builder(
              itemCount: course.modules.length,
              itemBuilder: (context, index) {
                Module module = course.modules[index];
                return ListTile(
                  title: Text(module.title),
                  onTap: () {
                    // Navigation vers ModuleDetailScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ModuleDetailScreen(module: module),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ModuleDetailScreen extends StatelessWidget {
  final Module module;

  ModuleDetailScreen({required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(module.title),
      ),
      body: ListView.builder(
        itemCount : module.chapters.length,
        itemBuilder: (context, index) {
          Chapter chapter = module.chapters[index];
          return ListTile(
            title: Text(chapter.title),
            onTap: () {
// Navigation vers ChapterDetailScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterDetailScreen(chapter: chapter),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChapterDetailScreen extends StatelessWidget {
  final Chapter chapter;

  ChapterDetailScreen({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapter.title),
      ),
      body: ListView.builder(
        itemCount: chapter.lessons.length,
        itemBuilder: (context, index) {
          Lesson lesson = chapter.lessons[index];
          return ListTile(
            title: Text(lesson.title),
            onTap: () {
              // Afficher le contenu de la leçon, soit dans un nouvel écran, soit dans un modal.
            },
          );
        },
      ),
    );
  }
}
