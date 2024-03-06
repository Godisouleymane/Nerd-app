import 'package:cloud_firestore/cloud_firestore.dart';

class Cours {
  final String titre;
  final String description;
  final String imageUrl;

  Cours(
      {required this.titre, required this.description, required this.imageUrl});

  factory Cours.fromMap(Map<String, dynamic> data) {
    return Cours(
      titre: data['titre'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}


Future<List<Cours>> getCours() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('selectedCours').get();
  return querySnapshot.docs.map((doc) => Cours.fromMap(doc.data() as Map<String, dynamic>)).toList();
}
