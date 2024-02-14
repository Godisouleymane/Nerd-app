import 'dart:math';
import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';

class CourseProgressScreen extends StatefulWidget {
  @override
  _CourseProgressScreenState createState() => _CourseProgressScreenState();
}

class _CourseProgressScreenState extends State<CourseProgressScreen> {
  Course? currentCourse;
  Module? selectedModule;

  @override
  void initState() {
    super.initState();
    loadCourse();
  }

  void loadCourse() async {
    Course? course = await getHtmlCourseFromFirestore();
    if (course != null && course.modules.isNotEmpty) {
      setState(() {
        currentCourse = course;
        selectedModule = course.modules.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progression du Cours'),
      ),
      body: currentCourse == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Ajouté pour permettre le défilement si le contenu dépasse la taille de l'écran
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => showModuleSelectionSheet(),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      color: Colors.blue,
                      width: double.infinity,
                      child: Text(selectedModule?.title ?? 'Chargement...'),
                    ),
                  ),
                  // Correction: Utiliser une Column pour disposer verticalement les chapitres
                  Column(
                    children: buildChapterWidgets(),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> buildChapterWidgets() {
    List<Widget> chapterWidgets = [];
    if (selectedModule != null) {
      for (var chapter in selectedModule!.chapters) {
        chapterWidgets.add(
          Container(
            margin: EdgeInsets.all(
                8.0), // Ajoute un peu d'espace autour de chaque chapitre
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100], // Couleur de fond du container
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
            ),
            child: Text(
              chapter.title,
              style: TextStyle(
                color: Colors.blueGrey, // Couleur du texte
                fontWeight: FontWeight.bold, // Gras
              ),
            ),
          ),
        );
      }
    }
    return chapterWidgets;
  }

  void showModuleSelectionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: currentCourse?.modules.length ?? 0,
          itemBuilder: (context, index) {
            Module module = currentCourse!.modules[index];
            return ListTile(
              title: Text(module.title),
              onTap: () {
                Navigator.pop(context); // Ferme le bottom sheet
                setState(() {
                  selectedModule = module;
                });
              },
            );
          },
        );
      },
    );
  }
}

class NodeWidget extends StatelessWidget {
  final String title;

  const NodeWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
