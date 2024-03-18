import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/widgets/showSnackbar.dart';
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
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  print("ID du module: ${data['id']}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CoursDetailScreen(moduleId: data['id']),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3,
                            spreadRadius: 3,
                            offset: const Offset(0, 3))
                      ]),
                  child: Column(
                    children: [
                      Image.asset('assets/vector.png'),
                      const Gap(8),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['titre'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                    data['estDebloquer']
                                        ? Icons.play_arrow
                                        : Icons.lock,
                                    size: 35,
                                    color: data['estDebloquer']
                                        ? const Color.fromARGB(255, 7, 255, 16)
                                        : Colors.red),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CoursDetailScreen extends StatelessWidget {
  final String moduleId;

  const CoursDetailScreen({Key? key, required this.moduleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Identifiant du module : $moduleId");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Leçons du Module',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cours')
            .doc('html_cours')
            .collection('modules')
            .doc(moduleId)
            .collection('lecons')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Une erreur s\'est produite : ${snapshot.error}'),
            );
          }

          // Si tout va bien, afficher les leçons
          final lessons = snapshot.data!.docs;
          print(lessons);
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lessonData = lessons[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () => lessonData['estDebloquer']
                    ? showNotification(context, 'Cette leçon est debloquée')
                    : showNotification(context, 'Cette leçon est bloquée'),
                child: ListTile(
                  title: Text(lessonData['titre'] ?? 'Titre inconnu'),
                  leading: const Icon(Icons.book),
                  trailing: lessonData['estDebloquer']
                      ? const Icon(Icons.play_arrow)
                      : const Icon(Icons.lock),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
