import 'package:code_crafters/main.dart';
import 'package:code_crafters/views/parcoursViews/shared-ui/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:code_crafters/views/choixParcours/gestureDetecto/gesture.dart';

class CourseProgressScreen extends StatelessWidget {
  const CourseProgressScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      appBar:MyAppBar(titre: ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Niveau Débutant',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CourseModule extends StatelessWidget {
  final String moduleName;
  final List<String> courses;

  CourseModule({required this.moduleName, required this.courses});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(moduleName),
      children: courses != null
          ? courses
              .map(
                (course) => ListTile(
                  title: Text(course),
                  onTap: () {
                    // Gérer le tap sur un cours
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cours sélectionné: $course'),
                      ),
                    );
                  },
                ),
              )
              .toList()
          : [],
    );
  }
}
