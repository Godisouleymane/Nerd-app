import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcours/html.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    if (_user != null) {
      return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final selectedContainerId =
                snapshot.data!.get('selectedContainerId');

            if (selectedContainerId == null) {
              return IntroductionPage();
            } else if (selectedContainerId == 'html') {
              return HTMLView();
            } else {
              return Placeholder(); // Remplacez-le par le widget souhaité
            }
          } else {
            return CircularProgressIndicator(); // Indicateur de chargement
          }
        },
      );
    } else {
      return OnBoardingScreen();
    }
  }
}
