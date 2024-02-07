import 'package:code_crafters/provider/containerIdProvider.dart';
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
    final selectedContainerId =
        Provider.of<SelectedContainerIdProvider>(context).selectedContainerId;

    if (_user != null) {
      if (selectedContainerId == 'html') {
        return const HTMLView();
      } else {
        return Placeholder();
      }
    } else {
      return OnBoardingScreen();
    }
  }
}

