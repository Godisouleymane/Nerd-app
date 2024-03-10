import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseModulesScreen extends StatelessWidget {
  final String courseId;

  CourseModulesScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cours')
            .doc(courseId)
            .collection('modules')
            .orderBy('ordre')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator(color: Colors.teal,);

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> module =
                  document.data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: Image.asset("assets/vector.png",
                      width: MediaQuery.of(context).size.width,
                      height: 200), // Remplacez par l'URL de votre image
                  title: Text(module['titre']),
                  trailing: Icon(
                    module['estDebloquer'] ? Icons.play_arrow : Icons.lock,
                    color: module['estDebloquer'] ? Colors.green : Colors.red,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
