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
    courseFuture = getHtmlCourseFromFirestore();
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
              final modules = courseData['modules'] as List<dynamic>? ?? [];
              return ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  final module = modules[index] as Map<String, dynamic>;
                 final lessons = module['lesson'] as List<dynamic>? ?? [];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TimelineTile(
                      alignment: TimelineAlign.start,
                      lineXY: 0.3,
                      isFirst: index == 0,
                      isLast: index == modules.length - 1,
                      
                      indicatorStyle: IndicatorStyle(
                        width: 40,
                        color:
                            module['isUnlocked'] ? Colors.green : Colors.grey,
                        iconStyle: IconStyle(
                          iconData: module['isUnlocked']
                              ? Icons.play_arrow
                              : Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                     endChild: ExpansionTile(
                        title: Text(module['title']),
                        children: <Widget>[
                          SizedBox(
                            // Hauteur dynamique basée sur le nombre de leçons, par exemple
                            height: lessons.length *
                                60.0, // Ajustez en fonction de la hauteur de chaque ListTile
                            child: SingleChildScrollView(
                              child: Column(
                                children: lessons.map<Widget>((lesson) {
                                  final lessonData =
                                      lesson as Map<String, dynamic>;
                                  return ListTile(
                                    title: Text(lessonData['title']),
                                    subtitle: Text(lessonData['content']),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                  
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Aucune donnée de cours disponible.'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur lors du chargement des données'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
