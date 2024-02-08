import 'package:code_crafters/provider/cours_model.dart';
import 'package:code_crafters/views/choixParcours/introduction.dart';
import 'package:code_crafters/views/parcours/html.dart';
import 'package:code_crafters/views/widgets/onBoarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    String selectedContainerId =
        Provider.of<ContainerSelectionModel>(context).selectedContainerId;
    if (_user != null) {
      
    } else {
      return OnBoardingScreen();
    }
  }
}
