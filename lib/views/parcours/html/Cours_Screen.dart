import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseModulesScreen extends StatefulWidget {
  final String courseId;

  CourseModulesScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseModulesScreenState createState() => _CourseModulesScreenState();
}

class _CourseModulesScreenState extends State<CourseModulesScreen> {
  @override
  Widget build(BuildContext context) {
    // Récupération de l'utilisateur actuel
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Si aucun utilisateur n'est connecté, redirigez ou affichez un message
      return const Scaffold(
        body: Center(
          child:
              Text("Veuillez vous connecter pour accéder au contenu du cours."),
        ),
      );
    }

    // Stream pour écouter les changements dans les modules basés sur l'ID du cours et la progression de l'utilisateur
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('progressionUtilisateurs')
            .doc(user.uid)
            .collection('coursProgression')
            .doc(widget.courseId)
            .snapshots(),
        builder: (context, snapshotProgression) {
          if (!snapshotProgression.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Extraction de la progression actuelle
          var userProgress =
              snapshotProgression.data!.data() as Map<String, dynamic>?;
          int currentModuleIndex =
              userProgress != null ? userProgress['progression'] as int : 0;

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cours')
                .doc(widget.courseId)
                .collection('modules')
                .orderBy('ordre')
                .snapshots(),
            builder: (context, snapshotModules) {
              if (!snapshotModules.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              var modules = snapshotModules.data!.docs;

              return ListView.builder(
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  var module = modules[index].data() as Map<String, dynamic>;
                  bool estDebloquer = index <= currentModuleIndex;

                  return ListTile(
                    leading: Icon(estDebloquer ? Icons.play_arrow : Icons.lock),
                    title: Text(module['titre']),
                    onTap: estDebloquer
                        ? () {
                            // Logique pour ouvrir le module
                          }
                        : null,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
