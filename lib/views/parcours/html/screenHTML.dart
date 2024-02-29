import 'package:code_crafters/services/get_courses.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HtmlVieww extends StatefulWidget {
  @override
  _HtmlViewwState createState() => _HtmlViewwState();
}

class _HtmlViewwState extends State<HtmlVieww> {
  int selectedModuleIndex = 0; // Index du module sélectionné, 0 par défaut
  Future<Map<String, dynamic>?>? courseFuture;

  @override
  void initState() {
    super.initState();
    courseFuture =
        getHtmlCourseFromFirestore(); 
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
              final selectedModule = modules[selectedModuleIndex];
              final lessons = selectedModule['lesson'] as List<dynamic>? ?? [];

              return Column(
                children: [
                  GestureDetector(
                    onTap: () => showModulesBottomSheet(context, modules),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.blueAccent,
                      child: Text(selectedModule['title']),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.1,
                          indicatorStyle: IndicatorStyle(
                            width: 20,
                            color: Colors.green,
                            iconStyle: IconStyle(
                                iconData: Icons.check, color: Colors.white),
                          ),
                          endChild: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(lessons[index]['title']),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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

  void showModulesBottomSheet(BuildContext context, List<dynamic> modules) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: modules.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(modules[index]['title']),
              onTap: () {
                setState(() {
                  selectedModuleIndex = index;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}


