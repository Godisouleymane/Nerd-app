import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Fonction pour initialiser la progression de l'utilisateur

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Fonction pour initialiser la progression de l'utilisateur dans le cours HTML
void initializeHTMLCourseProgressForUser() async {
  // Obtenir l'UID de l'utilisateur authentifié
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Identifiant fixe du HTML
  String courseId = "html";

  if (userId != null) {
   
    Map<String, bool> modulesProgress = {
      'Introduction à HTML': true, // Le premier module est débloqué
      // modules verrouillés initialement
      'Structure et Sémantique': false,
      'Liens, Images et Médias': false,
      'Bonnes Pratiques et Normes': false,
    };

    // Enregistrer la progression dans Firestore
    FirebaseFirestore.instance
        .collection('userProgress')
        .doc(userId)
        .collection('coursProgress')
        .doc(courseId)
        .set({'modulesProgress': modulesProgress})
        .then((_) => print(
            'Progression du cours HTML initialisée avec succès pour $userId.'))
        .catchError((error) => print(
            'Erreur lors de l\'initialisation de la progression du cours HTML: $error'));
  } else {
    print("Utilisateur non connecté.");
  }
}
