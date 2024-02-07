import 'package:code_crafters/services/course_selection_notifier.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcoursViews/html.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    final courseNotifier = Provider.of<CourseSelectionNotifier>(context);

    final selectedCourse = courseNotifier.selectedCourse;

    print('Selected course: $selectedCourse');

    if (_user != null && selectedCourse != null) {
      switch (selectedCourse.id) {
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
