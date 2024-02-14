import 'package:flutter/material.dart';
import 'package:code_crafters/services/get_courses.dart';
import 'package:provider/provider.dart';

class HtmlCourseScreen extends StatelessWidget {
  const HtmlCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Course?>(
      future: getHtmlCourseFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Une erreur s\'est produite: ${snapshot.error}'),
            ),
          );
        } else {
          return CourseInterface(course: snapshot.data!);
        }
      },
    );
  }
}

class CourseInterface extends StatelessWidget {
  final Course course;

  const CourseInterface({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstModule = course.modules.first;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: course.modules.length,
                    itemBuilder: (context, index) {
                      final module = course.modules[index];
                      return ListTile(
                        title: Text(module.title),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                firstModule.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: firstModule.chapters.length,
              itemBuilder: (context, index) {
                final chapter = firstModule.chapters[index];
                return ListTile(
                  title: Text(chapter.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
