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
      isUnlocked: true, // Le premier module est déverrouillé par défaut
      courses: const [
        'Comprendre les bases du HTML',
        'Structure d\'une page HTML',
        'Les éléments et balises HTML les plus courants',
        'Syntaxe de base HTML',
      ],
    ),
    CourseModule(
      moduleName: 'Module 2: Structure et Sémantique',
      isUnlocked: false, // Les autres modules sont verrouillés par défaut
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

  CourseModule? _selectedModule;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              _showModulesBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _selectedModule?.isUnlocked == true
                    ? Colors.blue
                    : Colors.grey.withOpacity(0.5),
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
  bool
      isUnlocked; // Ajoutez une variable pour indiquer si le module est déverrouillé ou non
  final List<String> courses;

  CourseModule({
    required this.moduleName,
    required this.isUnlocked,
    required this.courses,
  });
}
