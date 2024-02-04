import 'package:code_crafters/widgets/introduction.dart';
import 'package:code_crafters/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    if (_user == null) {
      return const OnBoardingScreen();
    } else {
      return const IntroductionPage();
    }
  }
}
