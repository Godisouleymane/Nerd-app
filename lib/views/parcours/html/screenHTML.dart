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
                          borderRadius: BorderRadius.circular(12.0),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.list,
                              size: 30,
                            ),
                            Flexible(
                              child: Text(
                                'Module : ${selectedModule?.title}' ??
                                    'Chargement...',
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
                    SizedBox(height: 40,),
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
          Column(
            children: [
              Container(
              width: MediaQuery.of(context).size.width,
             margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child:  Row(
                children: [
                  isUnlocked
                      ? const Icon(Icons.play_arrow, color: Colors.green)
                      : const Icon(Icons.lock, color: Colors.red),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      chapter.title,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ArrowWidget()
            ],
          )
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
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}

class ArrowWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context){
     return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Center(child: Icon(Icons.arrow_downward,)),
    );
  }
}