import 'package:flutter/material.dart';

class ScreenHtml extends StatefulWidget {
  const ScreenHtml({super.key});

  @override
  State<ScreenHtml> createState() => _ScreenHtmlState();
}

class _ScreenHtmlState extends State<ScreenHtml> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CourseModule(moduleName: 'Module 2: Structure et Sémantique', courses: [],),
              CourseModule(moduleName: 'Module 3: Liens, Images et Médias', courses: [],),
              CourseModule(moduleName: 'Module 4: Formulaires', courses: [],),
            ],
          ),
        ),
      ),
    );
  }
}