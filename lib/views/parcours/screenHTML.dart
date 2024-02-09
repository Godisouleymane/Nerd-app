import 'package:flutter/material.dart';

class ScreenHtml extends StatefulWidget {
  const ScreenHtml({Key? key}) : super(key: key);

  @override
  State<ScreenHtml> createState() => _ScreenHtmlState();
}

class _ScreenHtmlState extends State<ScreenHtml> {
  late CourseModule _selectedModule; // Change to late initialization

  final List<CourseModule> _courseModules = [
    CourseModule(
      moduleName: 'Module 1: Introduction à HTML',
      isUnlocked: true,
      courses: const [
        'Comprendre les bases du HTML',
        'Structure d\'une page HTML',
        'Les éléments et balises HTML les plus courants',
        'Syntaxe de base HTML',
      ],
    ),
    CourseModule(
      moduleName: 'Module 2: Structure et Sémantique',
      isUnlocked: false,
      courses: [],
    ),
    CourseModule(
      moduleName: 'Module 3: Liens, Images et Médias',
      isUnlocked: false,
      courses: [],
    ),
    CourseModule(
      moduleName: 'Module 4: Formulaires',
      isUnlocked: false,
      courses: [],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedModule =
        _courseModules.first; // Initialize selected module to the first module
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
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
                    children: [
                      Icon(
                        Icons.list,
                        size: 30,
                      ),
                      Text(
                        _selectedModule.moduleName,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 53, 32, 149),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             if (_selectedModule ==
                  _courseModules
                      .first) // Display chapters only if module 1 is selected
                SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _selectedModule.courses.length,
                itemBuilder: (BuildContext context, int index) {
                  final course = _selectedModule.courses[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        _selectedModule.isUnlocked
                            ? Icon(Icons.play_arrow, color: Colors.green)
                            : Icon(Icons.lock, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            course,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: _selectedModule.isUnlocked
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
          itemCount: _courseModules.length,
          itemBuilder: (BuildContext context, int index) {
            final courseModule = _courseModules[index];
            final isSelected = courseModule == _selectedModule;
            final textStyle = TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            );
            final tileColor = isSelected ? Colors.blue : null;

            return ListTile(
              title: Text(
                courseModule.moduleName,
                style: textStyle,
              ),
              tileColor: tileColor,
              onTap: () {
                if (courseModule.isUnlocked) {
                  setState(() {
                    _selectedModule = courseModule;
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Veuillez terminer le module précédent pour déverrouiller celui-ci.'),
                    ),
                  );
                  Navigator.pop(context);
                }
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
  bool isUnlocked;
  final List<String> courses;

  CourseModule({
    required this.moduleName,
    required this.isUnlocked,
    required this.courses,
  });
}
