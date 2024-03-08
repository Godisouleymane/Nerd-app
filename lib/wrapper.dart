import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcours/html/html.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user != null) {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Indicateur de chargement
          } else if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          } else if (!snapshot.data!.exists) {
            // Le document n'existe pas
            return const IntroductionPage();
          } else {
            // Le document existe, nous pouvons tenter d'accéder à `selectedContainerId`
            final data = snapshot.data!.data() as Map<String, dynamic>?;
            final selectedContainerId = data?['selectedContainerId'];

            if (selectedContainerId == null) {
              return const IntroductionPage();
            } else if (selectedContainerId == 'html') {
              return const HTMLView();
            } else {
              return const Placeholder();
            }
          }
        },
      );

    } else {
      return const OnBoardingScreen();
    }
  }
}
