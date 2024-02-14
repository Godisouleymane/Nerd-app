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
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedModule?.chapters.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(selectedModule?.chapters[index].title ?? ''),
                        // Ajoutez ici les onTap et autres interactions pour chaque chapitre
                      );
                    },
                  ),
                ),
              ],
            ),
    );
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
