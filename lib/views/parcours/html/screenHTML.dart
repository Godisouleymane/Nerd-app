import 'package:flutter/material.dart';
import 'package:code_crafters/services/get_courses.dart'; // Assurez-vous que vous importez correctement vos services
import 'package:provider/provider.dart';

class HtmlCourseScreen extends StatefulWidget {
  const HtmlCourseScreen({Key? key}) : super(key: key);

  @override
  _HtmlCourseScreenState createState() => _HtmlCourseScreenState();
}

class _HtmlCourseScreenState extends State<HtmlCourseScreen> {
  late Course? _htmlCourse;
  late Module _selectedModule;

  @override
  void initState() {
    super.initState();
    _loadHtmlCourse();
  }

  Future<void> _loadHtmlCourse() async {
    final course = await getHtmlCourseFromFirestore();
    setState(() {
      _htmlCourse = course;
      if (course != null && course.modules.isNotEmpty) {
        _selectedModule = course.modules.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: _htmlCourse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showModulesBottomSheet(context);
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
                                _selectedModule.title,
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
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _selectedModule.chapters.length,
                        itemBuilder: (BuildContext context, int index) {
                          final chapter = _selectedModule.chapters[index];
                          return ListTile(
                            title: Text(chapter.title),
                            // Vous pouvez ajouter une action lorsque l'utilisateur
                            // sélectionne un chapitre ici
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showModulesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _htmlCourse!.modules.length,
          itemBuilder: (BuildContext context, int index) {
            final module = _htmlCourse!.modules[index];
            final isSelected = module == _selectedModule;
            return ListTile(
              title: Text(module.title),
              selected: isSelected,
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedModule = module;
                });
              },
            );
          },
        );
      },
    );
  }
}
