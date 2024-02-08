import 'package:flutter/material.dart';

class ScreenHtml extends StatefulWidget {
  const ScreenHtml({Key? key}) : super(key: key);

  @override
  State<ScreenHtml> createState() => _ScreenHtmlState();
}

class _ScreenHtmlState extends State<ScreenHtml> {
  final List<CourseModule> _courseModules = [
    CourseModule(
      moduleName: 'Module 1: Introduction à HTML',
      courses: const [
        'Comprendre les bases du HTML',
        'Structure d\'une page HTML',
        'Les éléments et balises HTML les plus courants',
        'Syntaxe de base HTML',
      ],
    ),
    CourseModule(
      moduleName: 'Module 2: Structure et Sémantique',
      courses: [],
    ),
    CourseModule(
      moduleName: 'Module 3: Liens, Images et Médias',
      courses: [],
    ),
    CourseModule(
      moduleName: 'Module 4: Formulaires',
      courses: [],
    ),
  ];

  CourseModule? _selectedModule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  _showModulesBottomSheet(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    _selectedModule?.moduleName ?? _courseModules.first.moduleName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModulesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _courseModules.length,
          itemBuilder: (BuildContext context, int index) {
            final courseModule = _courseModules[index];
            return ListTile(
              title: Text(courseModule.moduleName),
              onTap: () {
                setState(() {
                  _selectedModule = courseModule;
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

class CourseModule {
  final String moduleName;
  final List<String> courses;

  CourseModule({
    required this.moduleName,
    required this.courses,
  });
}
