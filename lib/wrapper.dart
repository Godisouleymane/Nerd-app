import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcoursViews/html.dart';
import 'package:code_crafters/views/parcoursViews/parcours.dart';
import 'package:code_crafters/views/widgets/intro_screen/page1.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    final selectedCourse = CourseSelection().selectedCourse;

    if (_user != null && selectedCourse != null) {
      // Redirigez vers la page du cours sélectionné
       switch (selectedCourse) {
        case 'html':
          return HTMLView();
        default:
          return const introPage1();
      }
    } else {
      return OnBoardingScreen();
    }
  }
}
