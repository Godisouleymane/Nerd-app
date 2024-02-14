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
          : Column(
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
                // Utilisation d'un Stack pour positionner les chapitres comme un organigramme
                Expanded(
                  child: Stack(
                    children: buildChapterWidgets(),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> buildChapterWidgets() {
    List<Widget> chapterWidgets = [];
    if (selectedModule != null) {
      for (int i = 0; i < selectedModule!.chapters.length; i++) {
        var chapter = selectedModule!.chapters[i];
        chapterWidgets.add(
          Positioned(
            left: 50.0 *
                i, // Exemple de positionnement, ajustez selon votre besoin
            top: 100.0 *
                (i %
                    2), // Alterne les chapitres entre deux lignes pour l'exemple
            child: NodeWidget(title: chapter.title),
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
