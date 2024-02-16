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
      backgroundColor: Colors.grey.shade300,
      body: currentCourse == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModuleSelectionSheet();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.list,
                              size: 30,
                            ),
                            Flexible(
                              child: Text(
                               selectedModule?.title ?? 'Chargement...',
                                softWrap: true,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 53, 32, 149),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Correction: Utiliser une Column pour disposer verticalement les chapitres
                    Column(
                      children: buildChapterWidgets(),
                    ),
                  ],
                ),
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
            margin: const EdgeInsets.all(
                8.0), // Ajoute un peu d'espace autour de chaque chapitre
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.lightBlue[100], // Couleur de fond du container
              borderRadius: BorderRadius.circular(10), // Bordures arrondies
            ),
            child: Text(
              chapter.title,
              style: const TextStyle(
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
