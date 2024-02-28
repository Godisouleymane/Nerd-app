import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart'; 
import 'package:code_crafters/services/get_courses.dart';
import 'package:code_crafters/Cours_data/Les_Cours.dart'
    as Cours; // Utilisation de l'alias Cours

class HtmlView extends StatefulWidget {
  @override
  _HtmlViewState createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  Future<Cours.Course?>? courseFuture; // Utilisation de l'alias pour Course

  @override
  void initState() {
    super.initState();
    courseFuture =
        getHtmlCourseFromFirestore() as Future<Cours.Course?>?; // Assurez-vous que cette fonction retourne Future<Cours.Course?>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours HTML'),
      ),
      body: FutureBuilder<Cours.Course?>(
        future: courseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final course = snapshot.data!;
              return ListView.builder(
                itemCount: course.modules.length,
                itemBuilder: (context, index) {
                  Cours.Module module = course
                      .modules[index]; // Utilisation de l'alias pour Module
                  return TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.3,
                    isFirst: index == 0,
                    isLast: index == course.modules.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 40,
                      color: module.isUnlocked ? Colors.green : Colors.grey,
                      iconStyle: IconStyle(
                        iconData:
                            module.isUnlocked ? Icons.play_arrow : Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                    endChild: ExpansionTile(
                      title: Text(module.title),
                      children: module.lessons
                          .map((lesson) => ListTile(
                                title: Text(lesson.title),
                                subtitle: Text(lesson.content),
                              ))
                          .toList(),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Erreur lors du chargement des données'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
