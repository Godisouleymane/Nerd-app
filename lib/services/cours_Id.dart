import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// une fonction pour mettre à jour l'ID du conteneur sélectionné dans Firestore

Future<void> updateSelectedContainerId(User user, String containerId) async {
  final userDocRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid);
  await userDocRef.set(
      {
        'selectedContainerId': containerId,
      },
      SetOptions(
          merge:
              true)); // Utilisez SetOptions(merge: true) pour fusionner les données sans les remplacer
}
