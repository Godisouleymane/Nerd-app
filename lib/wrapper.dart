import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/login.dart';
import 'package:code_crafters/views/parcours/html/Cours_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
     final User? user = Provider.of<User?>(context);
    // si l'utilisateur n'est pas connecte
    if (user == null) {
      print('user est null');
      return const LoginPage();
    } else {
      // l'utilisateur est connecté, verifier sa progression
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('progressionUtilisateurs')
              .doc(user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset('assets/bulleLoading.json',
                    width: 300, height: 300));
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              // Aucune progression enregistree, retouner un ecran pour choisir un cours
              return const IntroductionPage();
            } else {
              // Progression trouvee, retourner l'ecran du cours.
              var data = snapshot.data!.data() as Map<String, dynamic>;
              String lastCourseId = data['coursId'];
              return CourseModulesScreen(courseId: lastCourseId);
            }
          });
    }
  }
}