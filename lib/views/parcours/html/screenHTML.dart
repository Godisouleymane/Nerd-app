import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';

class HtmlCourseScreen extends StatefulWidget {
  @override
  _HtmlCourseScreenState createState() => _HtmlCourseScreenState();
}

class _HtmlCourseScreenState extends State<HtmlCourseScreen> {
  Course? htmlCourse;

  @override
  void initState() {
    super.initState();
    // Appeler la fonction pour récupérer les données du cours HTML depuis Firestore
    getHtmlCourseFromFirestore().then((course) {
      setState(() {
        htmlCourse = course;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours HTML'),
      ),
      body: htmlCourse == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: htmlCourse!.modules.length,
              itemBuilder: (context, index) {
                Module module = htmlCourse!.modules[index];
                return ExpansionTile(
                  title: Text(module.title),
                  children: module.chapters.map((chapter) {
                    return ListTile(
                      title: Text(chapter.title),
                      onTap: () {
                        // Ajouter la logique pour afficher les leçons du chapitre
                      },
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}
