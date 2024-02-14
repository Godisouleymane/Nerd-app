import 'package:flutter/material.dart';

class HtmlCoursePage extends StatefulWidget {
  @override
  _HtmlCoursePageState createState() => _HtmlCoursePageState();
}

class _HtmlCoursePageState extends State<HtmlCoursePage> {
  @override
   void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Afficher le titre du module actuel
            Text(
              'Module 1: Introduction à HTML', // À remplacer par le titre du module actuel
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Afficher les chapitres du module actuel
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5, // À remplacer par le nombre de chapitres du module actuel
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Chapitre ${index + 1}'), // À remplacer par le titre du chapitre
                  onTap: () {
                    // Ajouter la logique pour gérer le tap sur un chapitre
                    // par exemple, ouvrir la leçon correspondante
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


  void _showModuleSelector(BuildContext context) {
    // Bottom sheet content
    Widget bottomSheetContent = Container(
      child: ListView.builder(
        itemCount: 6, // Replace with actual module count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Module ${index + 1}'),
            onTap: () {
              // Navigate to selected module
              // Replace with navigation logic
              Navigator.pop(context); // Close bottom sheet
            },
          );
        },
      ),
    );

    // Show bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (context) => bottomSheetContent,
    );
  }

