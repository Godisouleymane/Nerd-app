import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/login.dart';
import 'package:code_crafters/views/parcours/html/Cours_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Vérification si l'utilisateur est connecté ou non
    if (user == null) {
      return const LoginPage(); // Redirection vers la page de connexion
    } else {
      // L'utilisateur est connecté, on vérifie sa progression
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('progressionUtilisateurs')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/animations/bulleLoading.json',
                    width: 300, height: 300)); // Animation de chargement
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            // Si aucune progression n'est enregistrée, rediriger vers l'écran d'introduction
            return const IntroductionPage();
          } else {
            // Si une progression est trouvée, rediriger vers l'écran du dernier cours consulté
            var data = snapshot.data!.data() as Map<String, dynamic>;
            String lastCourseId = data['coursId'];
            // Assurez-vous que CourseModulesScreen accepte et traite correctement courseId
            return const CourseScreen();
          }
        },
      );
    }
  }
}
