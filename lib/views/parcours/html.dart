import 'package:code_crafters/views/parcours/screenHTML.dart';
import 'package:code_crafters/views/parcours/shared-ui/bottomNaviagtionBar.dart';
import 'package:code_crafters/views/parcours/shared-ui/communaute.dart';
import 'package:code_crafters/views/parcours/shared-ui/cours.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HTMLView extends StatefulWidget {
  const HTMLView({Key? key}) : super(key: key);

  @override
  State<HTMLView> createState() => _HTMLViewState();
}

class _HTMLViewState extends State<HTMLView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ScreenHtml(),
    const Communaute(),
    const Cours(),
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: const Color.fromARGB(255, 53, 32, 149),
            title: Row(
              children: [
                const Text(
                  'HTML',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(DevIcons.html5Plain, color: Colors.orange[800],),
              ],
            ),
            floating: true,
            pinned: false,
            actions: [
              if (user != null && user.photoURL != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                )
            ],
          ),
          SliverFillRemaining(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        screens: _screens, // Passer la liste d'écrans
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
          Colors.grey.shade400,
        ],
      ),
    );
  }
}
