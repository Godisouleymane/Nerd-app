import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcoursViews/html.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    final selectedCourse = CourseSelection().selectedCourse;

    print(
        'Selected course: $selectedCourse'); // Ajoutez cette ligne pour vérifier la valeur de selectedCourse

    if (_user != null && selectedCourse != null) {
      // Redirigez vers la page du cours sélectionné
      switch (selectedCourse) {
        case 'html':
          return HTMLView();
        default:
          return const IntroductionPage();
      }
    } else {
      return OnBoardingScreen();
    }
  }
}
