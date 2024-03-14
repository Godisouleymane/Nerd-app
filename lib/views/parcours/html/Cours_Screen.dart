import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cours')
          .doc('html_cours')
          .collection('modules')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Quelque chose s\'est mal passé'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Lottie.asset('assets/bulleLoading.json'));
        }

        // Construction de la ListView basée sur les documents dans la sous-collection 'modules'
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 3,
                      offset: const Offset(0, 3)
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Image.asset('assets/vector.png'),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(data['titre']),
                      Icon(data['estDebloquer'] ? Icons.play_arrow : Icons.lock, size: 30, color: data['estDebloquer'] ? Colors.teal : Colors.red)
                    ],)
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
