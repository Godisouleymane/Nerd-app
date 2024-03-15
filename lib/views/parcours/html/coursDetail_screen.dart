import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoursDetailScreen extends StatelessWidget {
  final Map<String, dynamic> moduleData;
  const CoursDetailScreen({super.key, required this.moduleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cours')
          .doc('html_cours')
          .collection('modules')
          .doc(moduleData['id'])
          .collection('lecons')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Quelques choses s\'est mal passé'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset('assets/bulleLoading.json'),
          );
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> lessonData =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: lessonData['titre'],
              leading: Icon(Icons.usb_rounded),
            );
          }).toList(),
        );
      },
    ));
  }
}
