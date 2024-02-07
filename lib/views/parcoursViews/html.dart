import 'package:code_crafters/views/parcoursViews/shared-ui/bottomNaviagtionBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HTMLView extends StatefulWidget {
  const HTMLView({super.key});

  @override
  State<HTMLView> createState() => _HTMLViewState();
}

class _HTMLViewState extends State<HTMLView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
     final _user = Provider.of<User?>(context);
    return Scaffold(
      appBar:  AppBar(
        title: Text('Parcours HTML'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(_user!.photoURL!),
            ),
          )
        ],
      ),
    );
  }
}
