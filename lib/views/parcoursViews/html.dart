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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 32, 149),
        title: const Text(
          'HTML',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
      body: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          screens: [],
          onTap: (int value) {
            setState(() {
              _currentIndex = value;
            });
          },
          icons: const [Icons.arrow_upward, Icons.business_sharp, Icons.school],
          labels: const ["Progression", "Communaute", "Cours"],
          selectedColors: const [
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.deepPurple,
          ],
          unselectedColors: [
            Colors.grey.shade400,
            Colors.grey.shade400,
          ]),
    );
  }
}
