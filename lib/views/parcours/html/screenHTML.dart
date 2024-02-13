import 'package:flutter/material.dart';

class HTMLCoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cours HTML'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Module Selector Button
          ElevatedButton(
            onPressed: () {
              // Show bottom sheet with module selector
              _showModuleSelector(context);
            },
            child: Text('Module actuel: Module 1'),
          ),
          // Lesson List
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with actual lesson count
              itemBuilder: (context, index) {
                // Replace with lesson tile widget
                return ListTile(
                  title: Text('Leçon ${index + 1}'),
                  trailing: Icon(
                      Icons.check_circle_outline), // Mark lesson as completed
                );
              },
            ),
          ),
          // Progress Indicator
          LinearProgressIndicator(
            value: 0.5, // Replace with actual progress value
          ),
        ],
      ),
    );
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
}

void main() {
  runApp(MaterialApp(
    home: HTMLCoursePage(),
  ));
}
