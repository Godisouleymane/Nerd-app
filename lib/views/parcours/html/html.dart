import 'package:code_crafters/views/parcours/html/screenHTML.dart';
import 'package:code_crafters/views/parcours/shared-ui/bottomNaviagtionBar.dart';
import 'package:code_crafters/views/parcours/shared-ui/communaute.dart';
import 'package:code_crafters/views/parcours/shared-ui/cours.dart';
import 'package:dev_icons/dev_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HTMLView extends StatefulWidget {
  const HTMLView({Key? key}) : super(key: key);

  @override
  State<HTMLView> createState() => _HTMLViewState();
}

class _HTMLViewState extends State<HTMLView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HtmlVieww(),
    const Communaute(),
    const Cours(),
  ];
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'HTML',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  DevIcons.html5Plain,
                  color: Colors.orange[800],
                ),
              ],
            ),
            floating: true,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(
                      lives,
                      (index) => const Icon(null),
                    ),
                  ),
                  // Vous pouvez ajouter d'autres widgets ici si nécessaire
                ],
              ),
            ),
            actions: [
              const Icon(Icons.notifications, color: Colors.white, size: 25),
              Gap(8),
              if (user != null && user.photoURL != null)
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                  ),
                ),
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
        icons: const [Icons.note, Icons.business_sharp, Icons.school],
        labels: const ["Modules", "Communauté", "Cours"],
        selectedColors: const [
          Colors.deepPurple,
          Colors.deepPurple,
          Colors.deepPurple,
        ],
        unselectedColors: [
          Colors.grey.shade500,
          Colors.grey.shade500,
          Colors.grey.shade500,
        ],
      ),
    );
  }
}
