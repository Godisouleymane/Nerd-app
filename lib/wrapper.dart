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
          } else {
            final selectedContainerId =
                snapshot.data!.get('selectedContainerId');

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
