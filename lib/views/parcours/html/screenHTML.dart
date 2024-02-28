
import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HtmlVieww extends StatefulWidget {
  @override
  _HtmlViewwState createState() => _HtmlViewwState();
}

class _HtmlViewwState extends State<HtmlVieww> {
  Future<Map<String, dynamic>?>? courseFuture;

  @override
  void initState() {
    super.initState();
    if (courseFuture == null) {
      courseFuture =
          getHtmlCourseFromFirestore() as Future<Map<String, dynamic>?>?;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: FutureBuilder<Map<String, dynamic>?>(
        future: courseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final courseData = snapshot.data!;
              // Utilisez une liste vide comme valeur par défaut si 'modules' est null
              final modules = courseData['modules'] as List<dynamic>? ?? [];
              return ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index] as Map<String, dynamic>;
                  // Utilisez une liste vide comme valeur par défaut si 'lessons' est null
                  final lessons = module['lessons'] as List<dynamic>? ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TimelineTile(
                      alignment: TimelineAlign.start,
                      lineXY: 0.3,
                      isFirst: index == 0,
                      isLast: index == modules.length - 1,
                      indicatorStyle: IndicatorStyle(
                        width: 40,
                        color: module['isUnlocked'] ? Colors.green : Colors.grey,
                        iconStyle: IconStyle(
                          iconData: module['isUnlocked']
                              ? Icons.play_arrow
                              : Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      endChild: ExpansionTile(
                        title: Text(module['title']),
                        children: lessons.map((lesson) {
                          final lessonData = lesson as Map<String, dynamic>;
                          return ListTile(
                            title: Text(lessonData['title']),
                            subtitle: Text(lessonData['content']),
                          );
                        }).toList(),
                      ),
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
